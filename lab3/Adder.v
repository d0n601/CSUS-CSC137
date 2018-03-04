//Ryan Kozak
//CSC 137 Class #32509 
//3rd Programming Assignment
// 
// Adder.v, 5-bit adder by linking single bit adders.
// compile: ~changw/ivl/bin/iverilog Adder.v
// run: ./a.out

`include "fa.v" // This is the stuff from the second assignment that's included in this one.

module TestMod;                     // the "main" thing
   parameter STDIN = 32'h8000_0000; // I/O address of keyboard input channel

   reg [7:0] str [1:3]; // typing in 2 chars at a time (decimal # and Enter key)
   reg [4:0] X, Y;      // 5-bit X, Y to sum
   wire [4:0] S;        // 5-bit Sum to see as result
   wire C5;             // like to know this as well from result of Adder

   // instantiate the big adder module (giving X and Y as input, getting S and C5 as output)
   BigAdder my_adder(X, Y, S, C5);

   initial begin

      $display("Enter X:");
      str[1] = $fgetc( STDIN );      // get first character.  
      str[2] = $fgetc( STDIN );      // get second character.
      str[3] = $fgetc( STDIN );      // get enter key
      str[1] = str[1] - 48;          // convert ASCII representation to integer.
      str[2] = str[2] - 48;          // convert ASCII representation to integer.
      str[1] = str[1] * 10;          // multiply digit in tens place by ten.
      X = str[1] + str[2];           // add tens place and ones place for decimal value of X.

      $display("Enter Y:");
      str[1] = $fgetc( STDIN );      // get first character.  
      str[2] = $fgetc( STDIN );      // get second character.
      str[3] = $fgetc( STDIN );      // get enter key
      str[1] = str[1] - 48;          // convert ASCII representation to integer.
      str[2] = str[2] - 48;          // convert ASCII representation to integer.
      str[1] = str[1] * 10;          // multiply digit in tens place by ten.
      Y = str[1] + str[2];           // add tens place and ones place for deimcal value of Y.

      #1; // wait until Adder gets them processed

      $display("X = %d (%b) \t Y = %d (%b)", X, X, Y, Y); // X and Y:
      $display("Result = %d (%b) C5 = %b", S, S, C5); // S and C5

   end
endmodule


module BigAdder(X, Y, S, C5); // 5-Bit Adder, chaining 5 sigle bit adders together

   input [4:0] X, Y;   // two 5-bit input items
   output [4:0] S;     // S should be similar
   output C5;          // another output for a different size
   wire [1:4] c;       // declare temporary wires

   FullAdder fa1(X[0], Y[0], 0, c[1], S[0]);  // get an instance of first adder, C0 is just hardcoded as 0
   FullAdder fa2(X[1], Y[1], c[1] ,c[2] ,S[1]); // get an instance of the second adder, carry in bit from first.
   FullAdder fa3(X[2], Y[2], c[2] ,c[3] ,S[2]); // get an instance of the third adder, carry in bit from second.
   FullAdder fa4(X[3], Y[3], c[3] ,c[4] ,S[3]); // get an instance of the fourth adder, carry in bit from third.
   FullAdder fa5(X[4], Y[4], c[4] ,C5 ,S[4]);  // get an instance of the fifth adder , carry in bit from fourth.

endmodule
