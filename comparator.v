module comparator (clock, comp_start, pe_out, pe_ready, vector_x,
  vector_y, best_dist, motion_x, motion_y);

input clock;
input comp_start;
input [127:0] pe_out;            // output all PEs (8 bits each times 16 of them) as one long vector
input [15:0] pe_ready;           // Goes high when the "that" Processing Element has new distortion
input [3:0] vector_x, vector_y;  // Motion vector being evaluated
output [7:0] best_dist;          // best distortion vector so far
output [3:0] motion_x, motion_y;
reg [7:0] best_dist;
reg [7:0] new_dist;
reg [3:0] motion_x, motion_y;
// flag to indicate if a new best reference block was found
reg new_best;

always@(posedge clock)
  if(comp_start == 0) best_dist <= 8'hFF;   // we are only initializing the variable here
  else if (new_best == 1) 
    begin
      best_dist <= new_dist;
      motion_x <= vector_x;
      motion_y <= vector_y;
    end 

always @(best_dist or pe_out or pe_ready)
  begin
    /* check which processing element has data ready to output. */
    case(pe_ready)
      16'b0000000000000001 :new_dist = pe_out[7:0];      // Value of PE0 when outout is ready
      16'b0000000000000010 :new_dist = pe_out[15:8];     // Value of PE1...
      16'b0000000000000100 :new_dist = pe_out[23:16];
      16'b0000000000001000 :new_dist = pe_out[31:24];
      16'b0000000000010000 :new_dist = pe_out[39:32];
      16'b0000000000100000 :new_dist = pe_out[47:40];
      16'b0000000001000000 :new_dist = pe_out[55:48];
      16'b0000000010000000 :new_dist = pe_out[63:56];
      16'b0000000100000000 :new_dist = pe_out[71:64];
      16'b0000001000000000 :new_dist = pe_out[79:72];
      16'b0000010000000000 :new_dist = pe_out[87:80];
      16'b0000100000000000 :new_dist = pe_out[95:88];
      16'b0001000000000000 :new_dist = pe_out[103:96];
      16'b0010000000000000 :new_dist = pe_out[111:104];
      16'b0100000000000000 :new_dist = pe_out[119:112];
      16'b1000000000000000 :new_dist = pe_out[127:120];
    endcase
    /** Set new_best to zero if no processing element ready (or-ing all
     *  bits together in pe_ready), or if
     *  processing has not started yet.
     */
    if ((|pe_ready == 0) || (comp_start == 0)) new_best = 0;
    else if (new_dist < best_dist) 
      new_best = 1;
    else 
      new_best = 0;
  end
endmodule

