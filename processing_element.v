/** We are using about 16 Processing Elements, since the reference block is
 *  16 * 16 in size. Thus, this processing elements can be pipelined together
 *  to perform fast, parallel search.
 */

module processing_element (clock ,r , s1 ,s2 ,s1s2_mux , new_dist,
   accumulate, r_pipe);
  
  input clock;
  /** Architecture consist of three small memories
   *  One for the reference block data (r)
   *  And one each for the left-hand and right-hand sides of the search widnow data
   */
  input [7:0] r;     // Position of reference block in second frame
  input [7:0] s1;    // first half of the search window in second frame
  input [7:0] s2;    // second half of the search window in second frame

  input  s1s2_mux;   // mux to select left, or right half pixels of search window
  input  new_dist;   //control inputs
  output [7:0] accumulate;    // output of this processing element to the comparator
  output [7:0] r_pipe;        // output to the next processing element (d-flipflop output)

  reg [7:0]  r_pipe, accumulate, accumulate_in, difference;
  reg carry;
  always @(posedge clock) r_pipe <= r;
  // accumulate_in is reused during sumation stage with
  // the absolute difference at the end of the processing element
  always @(posedge clock) accumulate <=  accumulate_in;

  /// Perform Sum of Absolute Difference (Distortion Figure) algorithm
  always @(r or s1 or s2 or s1s2_mux or new_dist or accumulate)
    begin
      // First multiplexer in RTL
      if (s1s2_mux)
        difference = (r - s1);   /*< if multiplexer picks s1. */
      else
        difference = (r - s2);   /*< if multiplexer picks s2. */

      /// we use absolute difference values only, so eliminate negative sign
      if (difference < 0) difference = 0 - difference;
         // store saturated value in the carry after the summation
        {carry, accumulate_in} = difference + accumulate;
        // Second Multiplexer
        if (carry == 1) accumulate_in = 8'hFF;    // saturate
        if (new_dist == 1) accumulate_in = difference;
    /// start new Distortion calculation
    end
endmodule
