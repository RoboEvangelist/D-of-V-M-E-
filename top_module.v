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
// wires for all Reference Blocks
wire [7:0] r, Rpipe0, Rpipe1, Rpipe2, Rpipe3, Rpipe4, Rpipe5, Rpipe6, Rpipe7, Rpipe8, Rpipe9, Rpipe10, Rpipe11, Rpipe12;
wire [7:0] Rpipe13, Rpipe14;   
 
// Calling the comparator and controller files    
comparator comparador(.clock(clock), .comp_start(comp_start), .pe_out(pe_out),
   .pe_ready(pe_ready), .vector_x(vector_x), .vector_y(vector_y),
   .best_dist(best_dist), .motion_x(motion_x), .motion_y(motion_y));
   
controller controlador(.clock(clock), .start(start), .s1s2_mux(s1s2_mux),
   .new_dist(new_dist), .comp_start(comp_start), .pe_ready(pe_ready),
   .vector_x(vector_x), .vector_y(vector_y), .address_r(address_r),
   .address_s1(address_s1), .address_s2(address_s2));   

//  Below is how to call the pe modules
processing_element pe0(.clock(clock), .r(r), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[0]), .new_dist(new_dist[0]), .accumulate(pe_out [7 : 0]) , .Rpipe(Rpipe0));
processing_element pe1(.clock(clock), .r(Rpipe0), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[1]), .new_dist(new_dist[1]), .accumulate(pe_out [15 : 8]) , .Rpipe(Rpipe1));  
processing_element pe2(.clock(clock), .r(Rpipe1), .s1(s1), .s2(s2), .s1s2_mux(s1s2_mux[2]), .new_dist(new_dist[2]), .accumulate(pe_out [23 : 16]) , .Rpipe(Rpipe2));  
processing_element pe3(.clock(clock), .r(Rpipe2), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[3]), .new_dist(new_dist[3]), .accumulate(pe_out [31 : 24]) , .Rpipe(Rpipe3));    
processing_element pe4(.clock(clock), .r(Rpipe3), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[4]), .new_dist(new_dist[4]), .accumulate(pe_out [39 : 32]) , .Rpipe(Rpipe4));  
processing_element pe5(.clock(clock), .r(Rpipe4), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[5]), .new_dist(new_dist[5]), .accumulate(pe_out [47 : 40]) , .Rpipe(Rpipe5));  
processing_element pe6(.clock(clock), .r(Rpipe5), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[6]), .new_dist(new_dist[6]), .accumulate(pe_out [55 : 48]) , .Rpipe(Rpipe6));       
processing_element pe7(.clock(clock), .r(Rpipe6), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[7]), .new_dist(new_dist[7]), .accumulate(pe_out [63 : 56]) , .Rpipe(Rpipe7));  
processing_element pe8(.clock(clock), .r(Rpipe7), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[8]), .new_dist(new_dist[8]), .accumulate(pe_out [71 : 64]) , .Rpipe(Rpipe8));  
processing_element pe9(.clock(clock), .r(Rpipe8), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[9]), .new_dist(new_dist[9]), .accumulate(pe_out [79 : 72]) , .Rpipe(Rpipe9));    
processing_element pe10(.clock(clock), .r(Rpipe9), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[10]), .new_dist(new_dist[10]), .accumulate(pe_out [87 : 80]) , .Rpipe(Rpipe10));  
processing_element pe11(.clock(clock), .r(Rpipe10), .s1(s1]), .s2(s2]), .s1s2_mux(s1s2_mux[11]), .new_dist(new_dist[11]), .accumulate(pe_out [95 : 88]) , .Rpipe(Rpipe11));  
processing_element pe12(.clock(clock), .r(Rpipe11), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[12), .new_dist(new_dist[12]), .accumulate(pe_out [103 : 96]) , .Rpipe(Rpipe12));        
processing_element pe13(.clock(clock), .r(Rpipe12), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[13]), .new_dist(new_dist[13]), .accumulate(pe_out [111 : 104]) , .Rpipe(Rpipe13));  
processing_element pe14(.clock(clock), .r(Rpipe13), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[14]), .new_dist(new_dist[14]), .accumulate(pe_out [119 : 112]) , .Rpipe(Rpipe14));  
processing_element pe15(.clock(clock), .r(Rpipe14), .s1(s1]), .s2(s2), .s1s2_mux(s1s2_mux[15]), .new_dist(new_dist[15]), .accumulate(pe_out [127 : 120]) , .Rpipe(Rpipe15));  
    
endmodule
