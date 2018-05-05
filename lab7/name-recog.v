// Ryan Kozak 
// CSC137 Class #32509
//
// 7th Programming Assignment
// sequence recognizer, recognize input of "Ryan" by output match = 1
//
// compile: ~changw/ivl/bin/iverilog name-recog.v
// run: ./a.out 

module TestMod;

   parameter STDIN = 32'h8000_0000; // keyboard-input file-handle address

   reg clk;
   reg [6:0] str [1:5];  // to what's to be entered
   wire match;           // to be set 1 when matched
   reg [6:0] ascii;      // each input letter is an ASCII bitmap

   RecognizerMod my_recognizer(clk, ascii, match);

   initial begin
      $display("Enter the the magic sequence: ");
      str[1] = $fgetc(STDIN);  // 1st letter
      str[2] = $fgetc(STDIN); // 2nd letter
      str[3] = $fgetc(STDIN); // 3rd letter
      str[4] = $fgetc(STDIN); // 4th letter
      str[5] = $fgetc(STDIN); // 5th letter (space)

      $display("Time clk    ascii       match");
      $monitor("%4d   %b    %c %b   %b", $time, clk, ascii, ascii, match);

      clk = 0;

      ascii = str[1];
      #1 clk = 1; #1 clk = 0;
      ascii = str[2];
      #1 clk = 1; #1 clk = 0;		
      ascii = str[3];
      #1 clk = 1; #1 clk = 0;
      ascii = str[4];
      #1 clk = 1;
   end

endmodule



module RecognizerMod(clk, ascii, match);

   input clk;
   input [6:0] ascii;
   output match;

   wire [0:4] Q [0:6];   // 5-input sequence, 7 bits each
   wire [6:0] submatch;  // all bits matched (7 5-bit sequences)

   wire [0:6] invQ;// inverted signals

   //         654 3210   Q
   //     hex binary
   // 'W' 57  101 0111 < q2
   // 'c' 63  110 0011 < q1
   // '7' 37  011 0111 < q0

   RippleMod Ripple6(clk, ascii[6], Q[6]);
   RippleMod Ripple5(clk, ascii[5], Q[5]);
   RippleMod Ripple4(clk, ascii[4], Q[4]);
   RippleMod Ripple3(clk, ascii[3], Q[3]);
   RippleMod Ripple2(clk, ascii[2], Q[2]);
   RippleMod Ripple1(clk, ascii[1], Q[1]);
   RippleMod Ripple0(clk, ascii[0], Q[0]);

   not(invQ[6], Q[6][0]);
   not(invQ[5], Q[5][0]);
   not(invQ[4], Q[4][0]);
   not(invQ[3], Q[3][0]);
   not(invQ[2], Q[2][0]);
   not(invQ[1], Q[1][0]);
   not(invQ[0], Q[0][0]);

   and(submatch[6], Q[6][4], Q[6][3], Q[6][2], Q[6][1], invQ[6]);

   and(match, submatch[6]);

endmodule



module RippleMod(clk, ascii_bit, q);

   input clk, ascii_bit;
   output [0:4] q;

   reg [0:4] q;          // flipflops

   always @(posedge clk) begin
      q[0] <= q[4];
      q[1] <= q[0];
      q[2] <= q[1];
      q[3] <= q[2];
      q[4] <= q[3];
   end

   initial q = 5'b00000;

endmodule

