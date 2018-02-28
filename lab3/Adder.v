//Ryan Kozak
//CSC 137 
//
// LAB 3 SKELETON CODE
//
module TesttMod;                     // the "main" thing
   parameter STDIN = 32'h8000_0000; // I/O address of keyboard input channel

   reg [7:0] str [1:3]; // typing in 2 chars at a time (decimal # and Enter key)
   reg [4:0] X, Y;      // 5-bit X, Y to sum
   wire [4:0] S;        // 5-bit Sum to see as result
   wire C5;             // like to know this as well from result of Adder

   instantiate the big adder module (giving X and Y as input, getting S and C5 as output)

   initial begin
      prompt for entering X: $display("Enter X: ");
      get 1st character:        --> str[1] = $fgetc(STDIN);
      get 2nd character:        --> str[2] = $fgetc(STDIN);
      and the ENTER key:        --> ...
      convert str to value for X:
         str[1] - 48 first, then times 10, then + str[2] - 48

      do the above to get input and convert it to Y

      #1; // wait until Adder gets them processed
      $display X and Y (run demo to see display format)
      and
      $display S and C5 (run demo to see display format)
   end
endmodule

module BigAdder(X, Y, S, C5);
   input [4:0] X, Y;   // two 5-bit input items
   output ...          // S should be similar
   output ...          // another output for a different size

   ...                 // declare temporary wires

   ... (get an instance of a full adder, C0 is just hardcoded as 0)
   ... (get another full adder...)
   ... (get another full adder...)
   ... (get another full adder...)
   ... (get another full adder...)
endmodule

module FullAdderMod(...); // single-bit adder module
   ... code the full adder (like in previous assignment) ...
endmodule

module MajorityMod(...); // carry-bit generator module
   ... code the full adder (like in previous assignment) ...
endmodule

module ParityMod(...); // sum-bit generator module
   ... code the full adder (like in previous assignment) ...
endmodule

