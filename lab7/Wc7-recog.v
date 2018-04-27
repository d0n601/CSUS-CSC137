// Wc7-recog.v
// sequence recognizer, recognize input of "Wc7" by ouput match = 1

module TestMod;
   parameter STDIN = 32'h8000_0000; // keyboard-input file-handle address

   reg clk;
   reg [6:0] str [1:4];  // to what's to be entered
   wire match;           // to be set 1 when matched
   reg [6:0] ascii;      // each input letter is an ASCII bitmap

   RecognizerMod my_recognizer(clk, ascii, match);

   initial begin
      $display("Enter the the magic sequence: ");
      str[1] = $fgetc(STDIN);  // 1st letter
      ...

      $display("Time clk    ascii       match");
      $monitor("%4d   %b    %c %b   %b", $time, clk, ascii, ascii, match);

      clk = 0;

      ascii = str[1];
      #1 clk = 1; #1 clk = 0;

      ...
   end
endmodule

module RecognizerMod(clk, ascii, match);
   input clk;
   input [6:0] ascii;
   output match;

   wire [0:2] Q [0:6];   // 3-input sequence, 7 bits each
   wire [6:0] submatch;  // all bits matched (7 3-bit sequences)

   wire ... // inverted signals

   //         654 3210   Q
   //     hex binary
   // 'W' 57  101 0111 < q2
   // 'c' 63  110 0011 < q1
   // '7' 37  011 0111 < q0

   RippleMod Ripple6(clk, ascii[6], Q[6]);
   ...

   not(invQ60, Q[6][0]);
   and(submatch[6], Q[6][2], Q[6][1], invQ60);
   ...

   and(match, ...);
endmodule

module RippleMod(clk, ascii_bit, q);
   input clk, ascii_bit;
   output [0:2] q;

   reg [0:2] q;          // flipflops

   always @(posedge clk) begin
      ...
   end

   initial q = 3'b000;
endmodule

