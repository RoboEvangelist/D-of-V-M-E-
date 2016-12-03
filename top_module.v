//  The top level module is like a main function that calls the other functions.  
//   In this case, we will declare the inputs of the top level module.  Then, you list the other modules.  
//   In our case, the other modules are the comparator, controller, and pe modules.  The pe module you will call 16 times.  
//   Below, is the way you would call the 1st 2 of 16 of the pe modules.  
//   That's it.  Of course, this only works if the other modules are working.



module top_module (clock,start,r,s1,s2,addressR,addresss1,addresss2,bestdist,
    motionx,motiony);

    reg clock;
    reg start;
    wire [7:0] addressR;
    wire [9:0] addresss1, addresss2;
    wire [7:0] bestdist;
    wire [3:0] motionx,motiony;
    reg [7:0] r;
    reg [7:0] s1;
    reg [7:0] s2;
    
    
//  Below is how to call the pe modules:    
//  pe pe0(.clock(clock), .R(R[7:0]), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[0]), .newDist(newDist[0]), .Accumulate(peout [7 : 0]) , .Rpipe(Rpipe0));
//  pe pe1(.clock(clock), .R(Rpipe0), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[1]), .newDist(newDist[1]), .Accumulate(peout [15 : 8]) , .Rpipe(Rpipe1));  
//  pe pe2(.clock(clock), .R(Rpipe1), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[2]), .newDist(newDist[2]), .Accumulate(peout [23 : 16]) , .Rpipe(Rpipe2));  
//  pe pe3(.clock(clock), .R(Rpipe2), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[3]), .newDist(newDist[3]), .Accumulate(peout [31 : 24]) , .Rpipe(Rpipe3));    
//  pe pe4(.clock(clock), .R(Rpipe3), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[4]), .newDist(newDist[4]), .Accumulate(peout [39 : 32]) , .Rpipe(Rpipe4));  
//  pe pe5(.clock(clock), .R(Rpipe4), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[5]), .newDist(newDist[5]), .Accumulate(peout [47 : 40]) , .Rpipe(Rpipe5));  
//  pe pe6(.clock(clock), .R(Rpipe5), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[6]), .newDist(newDist[6]), .Accumulate(peout [55 : 48]) , .Rpipe(Rpipe6));       
//  pe pe7(.clock(clock), .R(Rpipe6), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[7]), .newDist(newDist[7]), .Accumulate(peout [63 : 56]) , .Rpipe(Rpipe7));  
//  pe pe8(.clock(clock), .R(Rpipe7), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[8]), .newDist(newDist[8]), .Accumulate(peout [71 : 64]) , .Rpipe(Rpipe8));  
//  pe pe9(.clock(clock), .R(Rpipe8), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[9]), .newDist(newDist[9]), .Accumulate(peout [79 : 72]) , .Rpipe(Rpipe9));    
//  pe pe10(.clock(clock), .R(Rpipe9), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[10]), .newDist(newDist[10]), .Accumulate(peout [87 : 80]) , .Rpipe(Rpipe10));  
//  pe pe11(.clock(clock), .R(Rpipe10), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[11]), .newDist(newDist[11]), .Accumulate(peout [95 : 88]) , .Rpipe(Rpipe11));  
//  pe pe12(.clock(clock), .R(Rpipe11), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[12), .newDist(newDist[12]), .Accumulate(peout [103 : 96]) , .Rpipe(Rpipe12));        
//  pe pe13(.clock(clock), .R(Rpipe12), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[13]), .newDist(newDist[13]), .Accumulate(peout [111 : 104]) , .Rpipe(Rpipe13));  
//  pe pe14(.clock(clock), .R(Rpipe13), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[14]), .newDist(newDist[14]), .Accumulate(peout [119 : 112]) , .Rpipe(Rpipe14));  
//  pe pe15(.clock(clock), .R(Rpipe14), .s1(s1[7:0]), .s2(s2[7:0]), .s1s2mux(s1s2mux[15]), .newDist(newDist[15]), .Accumulate(peout [127 : 120]) , .Rpipe(Rpipe15));  
    
    
    
//    output [15:0] s1s2mux;
//    output [15:0] newdist;
//    output compstart;
//    output [15:0] peready;
//    output [3:0] vectorx, vectory;
//    output [7:0] addressR;
//    output [9:0] addresss1, addresss2;
//    reg [12:0] count; //Internal register counter 13 bit 
//    reg [12:0] temp;
//    reg [15:0] newdist;
//    reg compstart; 
//    reg completed;
//    reg [7:0] addressR;
//    reg [9:0] addresss1, addresss2;
//    reg [15:0] s1s2mux;
//    reg [3:0] vectorx, vectory;
//    reg [15:0] peready;
//    integer i;
//
//    always@(posedge clock)
//    begin
//        if (start==0) count = 0;
//        else  count = count + 12'b1;
//    end
//
//    always@(count)
//    begin
//        for (i=0;i<16;i=i+1)
//            begin
//                newdist[i] = (count[7:0] == i);
//                peready[i] = (newdist[i] && !(count<256));
//                s1s2mux[i] = (count[3:0]>=i);
//                compstart = (!(count<256));
//            end          
//            addressR = count[7:0];
//            addresss1 = (count[11:8] + count[7:4]) *31 + count[3:0] ;
//            temp = count[11:0] - 16;  
//            addresss2 = (temp[11:8] + temp[7:4])*31 + temp[3:0] + 16;
//            vectorx = count[3:0] - 8;
//            vectory = count[11:8] - 8;
//            completed = (count[12:0]== 16*(256+1));
//    end 
endmodule

