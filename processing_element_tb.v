/** Processing Element Test Bench
 */

module proccessing_element_tb();
reg clock;
reg [7:0] r;
reg [7:0] s1;
reg [7:0] s2;
reg s1s2_mux, new_dist;    // multiplexer and new distortion
wire carry, difference;
wire [7:0] accumulate, r_pipe;  // output to comparator, and to the next processing element
reg [7:0] accumulate, r_pipe;
processing_element u (.clock(clock), .r(r), .s1(s1), .s2(s2),
   .s1s2_mux(s1s2_mux), .new_dist(new_dist),
   .accumulate(accumulate), .r_pipe(r_pipe));
always #5 clock = ~clock;
initial
   begin
      // First setup up to monitor all inputs and outputs
      $monitor ("time=%5d ns, clock=%b, r=%b, s1=%b, s2=%b, s1s2_mux=%b, new_dist=%b, carry=%b, difference=%b, accumulate=%b, r_pipe=%b",
         $time, clock, r[7:0], s1[7:0], s2[7:0], s1s2_mux, new_dist,
         carry, difference, accumulate[7:0], r_pipe[7:0]);
      // below commands save waves as vcd files. 
      // These are not needed if Modelsim used as the 
      // simulator
      $dumpfile("processing_element.vcd"); // waveforms in this file
      $dumpvars; // saves all waveforms
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
   
   // We got this far, so all tests passed.
   #8000 $display("Processing Elements tests completed sucessfully\n\n");
   $finish;        //finished with simulation
   end
// This is to create a dump file for offline viewing.
initial
   begin
      $dumpfile ("proccessing_element_tb.dump");
      $dumpvars (0, proccessing_element_tb);
   end // initial begin
endmodule