// Ryan Kozak
// CSC137 Class #32509
// 
// adder.v
// compile: ~changw/ivl/bin/iverilog adder.v
// run: ./a.out

module MajorityModule(x, y, c_in, c_out);

   input x, y, c_in;
   output c_out;

   wire [0:2] a_wire;

   and(a_wire[0], x, y);
   and(a_wire[1], x, c_in);
   and(a_wire[2], y, c_in);

   or(c_out, a_wire[0], a_wire[1], a_wire[2]);

endmodule



module ParityModule(x, y, c_in, sum);

   input x, y, c_in;
   output sum;

   wire x_y;

   xor(x_y, x, y);
   
   xor(sum, x_y, c_in);

endmodule


module FullAdder(x, y, c_in, c_out, sum);
  
   input x, y, c_in;
   output c_out, sum;

   MajorityModule my_mm (x, y, c_in, c_out);
   ParityModule my_pm (x, y, c_in, sum);

endmodule


module TestMod;

   reg x, y, c_in;
   wire c_out, sum;

   FullAdder my_adder(x, y, c_in, c_out, sum);

   initial begin
      $display("Cin\tX\tY\t->\tCout\tSum");
      $monitor("%b\t%b\t%b\t  \t%b\t%b", c_in, x, y, c_out, sum);
   end

   initial begin
      
      c_in = 0; x = 0; y = 0; #1; //0
      c_in = 0; x = 0; y = 1; #1; //1
      c_in = 0; x = 1; y = 0; #1; //2
      c_in = 0; x = 1; y = 1; #1; //3 
      c_in = 1; x = 0; y = 0; #1; //4
      c_in = 1; x = 0; y = 1; #1; //5
      c_in = 1; x = 1; y = 0; #1; //6
      c_in = 1; x = 1; y = 1; #1; //7

    end

endmodule
