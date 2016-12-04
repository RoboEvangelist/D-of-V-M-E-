/** Processing Element Test Bench
 */

module pe_tb();
reg clock;
reg [7:0] r;
reg [7:0] s1;
reg [7:0] s2;
reg s1s2_mux, new_dist;
wire carry, difference;
wire [7:0] accumulate, r_pipe;
reg [7:0] accumulate, r_pipe;
proccessing_element u ( .clock(clock), .r(r), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux), .new_dist(new_dist), .accumulate(accumulate), .r_pipe(r_pipe));
always #5 clock = ~clock;
initial
   begin
      clock = 8'b0;
      r = 8'b0000;
      s1 = 8'b0000;
      s2 = 8'b0000;
      s1s2_mux = 8'b0000;
      new_dist = 8'b0000;
      
      #5 r = 8'b00001000;
         s1 = 8'b00000000;
         s2 = 8'b00001000;
      s1s2_mux = 8'b00000001;
      new_dist = 8'b00000001;
      
      #10 r = 8'b00000000;
         s1 = 8'b00000001;
         s2 = 8'b00000111;
         
      new_dist = 8'b00000000;
      #10 r = 8'b00000001;
      s2 = 8'b00000101;
      s1s2_mux = 8'b00000000;
      #10 r = 8'b00000010;
      s2 = 8'b00000111;
      s1s2_mux = 8'b00000001;
      #10 s1 = 8'b00000000;
      s2 = 8'b00000001;
      s1s2_mux = 8'b00000000;
      #100 r = 8'b00000101;
      s1 = 8'b11111111;
      s1s2_mux = 8'b00000001;
      #10 r = 8'b00000010;
      s1 = 8'b00000000;
      s1s2_mux = 8'b00000000;
   @(posedge clock);
   @(posedge clock);
   #8000 $finish;
   end
endmodule