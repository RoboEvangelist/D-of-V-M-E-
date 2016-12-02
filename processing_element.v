/** We are using about 16 Processing Elements, since the reference block is
 *  16 * 16 in size. Thus, this process elements can be pipelined together
 *  to perform parallel, faster search.
 */

module processing_element (clock ,r , s1 ,s2 ,s1s2mux , newdist, accumulate, rpipe);
  input clock;

  /** Architecture consist of three small memories
   *  One for the reference block data (r)
   *  And one each for the left- and right-hand sides of the search widnow data
   */
  input [7:0] r;     // Position of reference block in second frame
  input [7:0] s1;    // first half of the search window in second frame
  input [7:0] s2;    // second half of the search window in second frame

  input  s1s2mux;    // mux to select left, or right half pixels of search window
  input  newdist;    //control inputs
  output [7:0] accumulate;   // output to the comparator
  output [7:0] rpipe;        // output to the next processing element (d-flipflop output)

  reg [7:0]  rpipe,accumulate,accumulatein,difference;
  reg carry;
  always @(posedge clock) rpipe <= r;
  always @(posedge clock) accumulate <=  accumulatein;

  /// Perform Sum of Absolute Difference (Distortion Figure) algorithm
  always @(r or s1 or s2 or s1s2mux or newdist or accumulate)
    begin
      if (s1s2mux)
        difference = (r - s1);
      else
        difference = (r - s2);

      if (difference < 0) difference = 0 - difference;
        // absolute subtraction
        {carry,accumulatein} = accumulate + difference;
        if (carry == 1) accumulatein = 8'hFF;    // saturate
        if (newdist == 1) accumulatein = difference;
    // start new Distortion calculation
    end
endmodule

