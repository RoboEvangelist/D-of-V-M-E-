//  The top level module is like a main function that calls the other functions.  
//   In this case, we will declare the inputs of the top level module.  Then, you list the other modules.  
//   In our case, the other modules are the comparator, controller, and pe modules.  The pe module you will call 16 times.  
//   Below, is the way you would call the 1st 2 of 16 of the pe modules.  
//   That's it.  Of course, this only works if the other modules are working.

`include "processing_element.v"
`include "controller.v"
`include "comparator.v"

module top_module (clock, start, r, s1, s2, address_r, address_s1, address_s2,
   best_dist, motion_x, motion_y);

input clock, start;
input [7:0] r;
input [7:0] s1, s2;
output [7:0] best_dist, address_r;
output [3:0] motion_x, motion_y;
output [9:0] address_s1, address_s2;
wire comp_start;
wire [127:0] pe_out;
// We have 16 (one per Processing Element) multiplexers, new distortion models,
// "processing element ready" flags
wire [15:0] s1s2_mux, new_dist, pe_ready;
wire [9:0] address_s1, address_s2;
wire [7:0] best_dist, address_r;
wire [3:0] vector_x, vector_y;
// wires for all Reference Blocks PE flipflop output
wire [7:0] r, r_pipe0, r_pipe1, r_pipe2, r_pipe3, r_pipe4, r_pipe5, r_pipe6, r_pipe7, r_pipe8, r_pipe9, r_pipe10, r_pipe11, r_pipe12;
wire [7:0] r_pipe13, r_pipe14, r_pipe15;   
 
// Calling the comparator and controller files    
comparator comparador(.clock(clock), .comp_start(comp_start), .pe_out(pe_out),
   .pe_ready(pe_ready), .vector_x(vector_x), .vector_y(vector_y),
   .best_dist(best_dist), .motion_x(motion_x), .motion_y(motion_y));
   
controller controlador(.clock(clock), .start(start), .s1s2_mux(s1s2_mux),
   .new_dist(new_dist), .comp_start(comp_start), .pe_ready(pe_ready),
   .vector_x(vector_x), .vector_y(vector_y), .address_r(address_r),
   .address_s1(address_s1), .address_s2(address_s2));   

//  Below is how to call the pe modules
processing_element pe0(.clock(clock), .r(r), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[0]), .new_dist(new_dist[0]), .accumulate(pe_out [7 : 0]) , .r_pipe(r_pipe0));
processing_element pe1(.clock(clock), .r(r_pipe0), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[1]), .new_dist(new_dist[1]), .accumulate(pe_out [15 : 8]) , .r_pipe(r_pipe1));  
processing_element pe2(.clock(clock), .r(r_pipe1), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[2]), .new_dist(new_dist[2]), .accumulate(pe_out [23 : 16]) , .r_pipe(r_pipe2));  
processing_element pe3(.clock(clock), .r(r_pipe2), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[3]), .new_dist(new_dist[3]), .accumulate(pe_out [31 : 24]) , .r_pipe(r_pipe3));    
processing_element pe4(.clock(clock), .r(r_pipe3), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[4]), .new_dist(new_dist[4]), .accumulate(pe_out [39 : 32]) , .r_pipe(r_pipe4));  
processing_element pe5(.clock(clock), .r(r_pipe4), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[5]), .new_dist(new_dist[5]), .accumulate(pe_out [47 : 40]) , .r_pipe(r_pipe5));  
processing_element pe6(.clock(clock), .r(r_pipe5), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[6]), .new_dist(new_dist[6]), .accumulate(pe_out [55 : 48]) , .r_pipe(r_pipe6));       
processing_element pe7(.clock(clock), .r(r_pipe6), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[7]), .new_dist(new_dist[7]), .accumulate(pe_out [63 : 56]) , .r_pipe(r_pipe7));  
processing_element pe8(.clock(clock), .r(r_pipe7), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[8]), .new_dist(new_dist[8]), .accumulate(pe_out [71 : 64]) , .r_pipe(r_pipe8));  
processing_element pe9(.clock(clock), .r(r_pipe8), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[9]), .new_dist(new_dist[9]), .accumulate(pe_out [79 : 72]) , .r_pipe(r_pipe9));    
processing_element pe10(.clock(clock), .r(r_pipe9), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[10]), .new_dist(new_dist[10]), .accumulate(pe_out [87 : 80]) , .r_pipe(r_pipe10));  
processing_element pe11(.clock(clock), .r(r_pipe10), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[11]), .new_dist(new_dist[11]), .accumulate(pe_out [95 : 88]) , .r_pipe(r_pipe11));  
processing_element pe12(.clock(clock), .r(r_pipe11), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[12]), .new_dist(new_dist[12]), .accumulate(pe_out [103 : 96]) , .r_pipe(r_pipe12));        
processing_element pe13(.clock(clock), .r(r_pipe12), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[13]), .new_dist(new_dist[13]), .accumulate(pe_out [111 : 104]) , .r_pipe(r_pipe13));  
processing_element pe14(.clock(clock), .r(r_pipe13), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[14]), .new_dist(new_dist[14]), .accumulate(pe_out [119 : 112]) , .r_pipe(r_pipe14));  
processing_element pe15(.clock(clock), .r(r_pipe14), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[15]), .new_dist(new_dist[15]), .accumulate(pe_out [127 : 120]) , .r_pipe(r_pipe15));  
    
endmodule
