// Ryan Kozak
// CSC137 Class #32509
// 2nd Programming Assignment 
// adder.v
// compile: ~changw/ivl/bin/iverilog adder.v
// run: ./a.out

module MajorityModule(x, y, c_in, c_out); //Majority Module Definition (carry out)

   input x, y, c_in; // inputs
   output c_out; // carry out (out put)

   wire [0:2] a_wire; // array of extra wires

   and(a_wire[0], x, y); // first and gate
   and(a_wire[1], x, c_in); // second and gate
   and(a_wire[2], y, c_in); // third and gate 

   or(c_out, a_wire[0], a_wire[1], a_wire[2]); // or gate to output

endmodule



module ParityModule(x, y, c_in, sum); // Parity Module Definition

   input x, y, c_in; // inputs
   output sum; // sum (out put)

   wire x_y; // extra wire

   xor(x_y, x, y); // first xor gate
   
   xor(sum, x_y, c_in); // second xor gate

endmodule


module FullAdder(x, y, c_in, c_out, sum); // Full Adder (FA)
  
   /* I created this rather than calling the Majority Module
    * and Parity Module directly from the tester. In that case, 
    * the tester itself would really be the FullAdder.
    */

   input x, y, c_in; // inputs
   output c_out, sum; // outputs

   MajorityModule my_mm (x, y, c_in, c_out); // declare majority module
   ParityModule my_pm (x, y, c_in, sum); // declare partiy module
endmodule
