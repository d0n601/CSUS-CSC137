// d1x2.v, 1x2 decoder, arrays and composite modules
// //
// // how to compile: ~changw/ivl/bin/iverilog d1x2.v
// // how to run: ./a.out
//
module DecoderMod(s, o); // module definition
   input s;
   output [0:1] o;

   not(o[0], s);
   assign o[1] = s;
endmodule

module TestMod;
   reg s;
   wire [0:1] o;

   DecoderMod my_decoder(s, o); // create instance

   initial begin
      $monitor("%0d\t%b\t%b", $time, s, o);
      $display("Time  s  o");
      $display("--------------");
   end

   initial begin
      s = 0; #1;
      s = 1; #1;
      s = 0; #1;
      s = 1;
   end
endmodule
