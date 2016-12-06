`timescale 1ns/10ps
module timeunit;
   initial $timeformat(-9,1,"ns",9);
endmodule

module top_tb;
parameter CLKPERIOD = 20;
reg clock;
reg start;
wire [7:0] address_r;                // wire coming from the Reference Block Memory
wire [9:0] address_s1, address_s2;   // wires coming from the Search Window memory
wire [7:0] best_dist;                // best distortion value thus far
wire [3:0] motion_x, motion_y;       // current motion vector
reg [7:0] r;
reg [7:0] s1;
reg [7:0] s2;

reg [7:0] rmem [255:0];    // Each reference block memory has a size of 16 x 16 (or 256) pixels in size
reg [9:0] smem [960:0];    // Each search block memory in the second frame is a 31 x 31 (or 961) pixels size

integer i, j;              // keys of the for-loops

top_module u1(.clock(clock), .start(start), .r(r), .s1(s1), .s2(s2), .address_r(address_r),
   .address_s1(address_s1), .address_s2(address_s2), .best_dist(best_dist), .motion_x(motion_x), 
   .motion_y(motion_y));

always@(posedge clock)
begin    // fetch data from memory (the image frames)
   assign r = rmem[address_r];
   assign s1 = smem[address_s1];
   assign s2 = smem[address_s2];
end

initial 
   begin
      // First setup up to monitor all inputs and outputs
      $monitor ("time=%5d ns, clock=%b, r=%b, s1=%b, s2=%b, start=%b, address_r=%b, address_s1=%b, address_s2=%b, best_dist=%b, motion_x=%b, motion_y=%b, i=%d, j=%d",
         $time, clock, r[7:0], s1[7:0], s2[7:0], start, address_r[7:0], address_s1[9:0],
         address_s2[9:0], best_dist[7:0], motion_x[3:0], 
         motion_y[3:0], i, j);
      // below commands save waves as vcd files. 
      // These are not needed if Modelsim used as the 
      // simulator
      $dumpfile("top_tb.vcd"); // waveforms in this file
      $dumpvars;               // saves all waveforms
      
      clock=0;
      start=0;
      rmem[0]=256;
      for (i = 1; i < 256; i = i + 1)
      begin
         rmem[i] = 0; 
      end
      #20 rmem[1]=00;
      #20 rmem[2]=00;
      #20 rmem[3]=00;
      #20 rmem[4]=00;

      smem[0]=960;
      for(j = 0; j < 961 ; j = j + 1)
      begin
         smem[j]=0;
      end
      #20 smem[1]=00;
      #20 smem[2]=00; 
      #20 smem[3]=00;
      #20 smem[4]=00;

      smem[0]=960;
      for(j=0; j < 961; j = j + 1)
      begin
         smem[j]=0;
      end
      #20 smem[0]=00;
      #20 smem[1]=00;
      #20 smem[2]=00;
      #20 smem[3]=00;

//      $dumpfile("top_tb.vcd");
//      $dumpvars;

      #5 clock=1;
      #5 start=1;

      #10000 $finish;
   end
always #(CLKPERIOD/2) clock = ~clock;
// This is to create a dump file for offline viewing.
initial
   begin
      $dumpfile ("top_tb.dump");
      $dumpvars (0, top_tb);
   end // initial begin
endmodule
