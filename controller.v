module controller (clock, start, s1s2_mux, new_dist, comp_start,
   pe_ready, vector_x, vector_y, address_r, address_s1, address_s2);

input clock;
input start; // = 1 when 'going'
output [15:0] s1s2_mux;
output [15:0] new_dist;
output comp_start;
output [15:0] pe_ready;
output [3:0] vector_x, vector_y;
output [7:0] address_r;
output [9:0] address_s1, address_s2;
reg [15:0] s1s2_mux;
reg [15:0] new_dist;
reg comp_start;
reg [15:0] pe_ready;
reg [3:0] vector_x, vector_y;
reg [7:0] address_r;
reg [9:0] address_s1, address_s2;
reg [11:0] count;
reg completed;
reg [11:0] temp;
integer i;

always @(posedge clock)

if (completed == 0) count <= count + 1'b1;
else if (start == 0 ) count <= 12'b0;

always @(count)
   begin
      for (i = 0; i < 15; i = i + 1)
         begin
            // TODO: unroll this loop to increase speed.
            // Check the hardware footprint and power to see if
            // unrolling is benefitial at all
            new_dist[i] = (count[7:0] == i );
            pe_ready[i] = (new_dist[i] && !(count < 256));
            s1s2_mux[i] = (count[3:0] >= i);
            comp_start = (!(count < 256));
         end
      temp = count[11:0] - 16;
      address_r = count[7:0];
      address_s1 = (count[11:8] + count[7:4]) * 31 + count[3:0];
      address_s2 = (temp[11:8] + temp[7:4]) * 31 + temp[3:0] + 16;
      vector_x = count[3:0] - 8;
      vector_y = count[11:8] - 9;
      completed = (count[11:0] == (16 * 257) - 1);
end
endmodule
