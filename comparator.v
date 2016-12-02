module comparator (clock,compstart,peout,peready,vectorx,
  vectory,bestdist,motionx, motiony);

input clock;
input compstart;
input [127:0] peout;              // output all PEs (8 bits each times 16 of them) as one long vector
input [15:0] peready;             // Goes high when the "that" Processing Element has new distortion
input [3:0] vectorx, vectory;     // Motion vector being evaluated
output [7:0] bestdist;            // best distortion vector so far
output [3:0] motionx, motiony;
reg [7:0] bestdist;
reg [7:0] new_dist;
reg [3:0] motionx, motiony;
reg newbest;

always@(posedge clock)
  if(compstart == 0) bestdist <= 8'hFF;   // we are only initializing the variable here
  else if (newbest == 1) 
    begin
      motionx <= vectorx;
      motiony <= vectory;
      bestdist <= new_dist;
    end
  else
    begin
      motionx <= motionx;
      motiony <= motiony;
      bestdist <= bestdist;
    end 

always @(bestdist or peout or peready)
  begin
    /* check which processing element has data ready to output. */
    case(peready)
      16'b0000000000000001 :new_dist = peout[7:0];      // Value of PE0 when outout is ready
      16'b0000000000000010 :new_dist = peout[15:8];     // Value of PE1...
      16'b0000000000000100 :new_dist = peout[23:16];
      16'b0000000000001000 :new_dist = peout[31:24];
      16'b0000000000010000 :new_dist = peout[39:32];
      16'b0000000000100000 :new_dist = peout[47:40];
      16'b0000000001000000 :new_dist = peout[55:48];
      16'b0000000010000000 :new_dist = peout[63:56];
      16'b0000000100000000 :new_dist = peout[71:64];
      16'b0000001000000000 :new_dist = peout[79:72];
      16'b0000010000000000 :new_dist = peout[87:80];
      16'b0000100000000000 :new_dist = peout[95:88];
      16'b0001000000000000 :new_dist = peout[103:96];
      16'b0010000000000000 :new_dist = peout[111:104];
      16'b0100000000000000 :new_dist = peout[119:112];
      16'b1000000000000000 :new_dist = peout[127:120];
    endcase
    /** Set newbest to zero if no processing element ready, or if
     *  processing has not started yet.
     */
    if ((|peready == 0) || (compstart == 0)) newbest = 0;
    else if (new_dist < bestdist) 
      newbest = 1;
    else 
      newbest=0;
  end
endmodule

