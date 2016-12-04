//  The top level module is like a main function that calls the other functions.  
//   In this case, we will declare the inputs of the top level module.  Then, you list the other modules.  
//   In our case, the other modules are the comparator, controller, and pe modules.  The pe module you will call 16 times.  
//   Below, is the way you would call the 1st 2 of 16 of the pe modules.  
//   That's it.  Of course, this only works if the other modules are working.

module top_module (clock, start, r, s1, s2, address_r, address_s1, address_s2, best_dist,
    motion_x, motion_y);

    input clock;
    input [7:0] r, s1, s2;  // memory inputs
    input compstart;
    input [127:0] peout;
    input [15:0] peready;
    input [3:0] vectorx, vectory
    output [7:0] best_dist;
    output [3:0] motion_x, motion_y;
    
    input s1s2mux, newDist; // control inputs
    output [7:0] Accumulate, Rpipe;
    output [127:0] peout;
    output [7:0] r, Rpipe0, Rpipe1, Rpipe2, Rpipe3, Rpipe4, Rpipe5, Rpipe6, Rpipe7, Rpipe8, Rpipe9, Rpipe10, Rpipe11, Rpipe12;
    output [7:0] Rpipe13, Rpipe14;    
    
    reg clock;
    reg start;
    wire [7:0] address_r;
    wire [9:0] address_s1, address_s2;
    wire [7:0] best_dist;
    wire [3:0] motion_x,motion_y;
    reg [7:0] r;
    reg [7:0] s1;
    reg [7:0] s2;
    
    reg[7:0] best_dist, newdist;
    reg[3:0] motion_x, motion_y;
    reg newBest;
    
    reg [15:0] s1s2mux;
    reg [15:0] newDist;
    reg [127:0] peout;
    reg [7:0] r, Rpipe0, Rpipe1, Rpipe2, Rpipe3, Rpipe4, Rpipe5, Rpipe6, Rpipe7, Rpipe8, Rpipe9, Rpipe10, Rpipe11, Rpipe12;
    reg [7:0] Rpipe13, Rpipe14;   
 
    
// Calling the comparator and control files    
comparator c(.clock(clock), .compstart(compstart), .peout(peout), .peready(peready), .vectorx(vectorx), .vectory(vectory), .best_dist(best_dist), .motion_x(motion_x), .motion_y(motion_y));  
control cnt(.clock(clock), .start(start), .s1s2mux(s1s2mux), .newdist(newdist), .compstart(compstart), .peready(peready), .vectorx(vectorx), .vectory(vectory), .address_r(address_r), .address_s1(address_s1), .address_s2(address_s2))     

//  Below is how to call the pe modules
pe pe0(.clock(clock), .r(r[7:0]), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[0]), .newDist(newDist[0]), .Accumulate(peout [7 : 0]) , .Rpipe(Rpipe0));
pe pe1(.clock(clock), .r(Rpipe0), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[1]), .newDist(newDist[1]), .Accumulate(peout [15 : 8]) , .Rpipe(Rpipe1));  
pe pe2(.clock(clock), .r(Rpipe1), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[2]), .newDist(newDist[2]), .Accumulate(peout [23 : 16]) , .Rpipe(Rpipe2));  
pe pe3(.clock(clock), .r(Rpipe2), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[3]), .newDist(newDist[3]), .Accumulate(peout [31 : 24]) , .Rpipe(Rpipe3));    
pe pe4(.clock(clock), .r(Rpipe3), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[4]), .newDist(newDist[4]), .Accumulate(peout [39 : 32]) , .Rpipe(Rpipe4));  
pe pe5(.clock(clock), .r(Rpipe4), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[5]), .newDist(newDist[5]), .Accumulate(peout [47 : 40]) , .Rpipe(Rpipe5));  
pe pe6(.clock(clock), .r(Rpipe5), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[6]), .newDist(newDist[6]), .Accumulate(peout [55 : 48]) , .Rpipe(Rpipe6));       
pe pe7(.clock(clock), .r(Rpipe6), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[7]), .newDist(newDist[7]), .Accumulate(peout [63 : 56]) , .Rpipe(Rpipe7));  
pe pe8(.clock(clock), .r(Rpipe7), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[8]), .newDist(newDist[8]), .Accumulate(peout [71 : 64]) , .Rpipe(Rpipe8));  
pe pe9(.clock(clock), .r(Rpipe8), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[9]), .newDist(newDist[9]), .Accumulate(peout [79 : 72]) , .Rpipe(Rpipe9));    
pe pe10(.clock(clock), .r(Rpipe9), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[10]), .newDist(newDist[10]), .Accumulate(peout [87 : 80]) , .Rpipe(Rpipe10));  
pe pe11(.clock(clock), .r(Rpipe10), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[11]), .newDist(newDist[11]), .Accumulate(peout [95 : 88]) , .Rpipe(Rpipe11));  
pe pe12(.clock(clock), .r(Rpipe11), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[12), .newDist(newDist[12]), .Accumulate(peout [103 : 96]) , .Rpipe(Rpipe12));        
pe pe13(.clock(clock), .r(Rpipe12), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[13]), .newDist(newDist[13]), .Accumulate(peout [111 : 104]) , .Rpipe(Rpipe13));  
pe pe14(.clock(clock), .r(Rpipe13), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[14]), .newDist(newDist[14]), .Accumulate(peout [119 : 112]) , .Rpipe(Rpipe14));  
pe pe15(.clock(clock), .r(Rpipe14), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[15]), .newDist(newDist[15]), .Accumulate(peout [127 : 120]) , .Rpipe(Rpipe15));  
    
 
endmodule
