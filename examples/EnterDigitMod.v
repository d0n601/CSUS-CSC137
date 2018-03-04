// EnterDigitMod.v
// enter a two decimal digit 00 ~ 31, return the same thing....
// to compile: ~changw/ivl/bin/iverilog EnterDigit.v
// to run: a.out

module EnterDigits;
// stdin is given by default, console input (keyboard)
   parameter STDIN = 32'h8000_0000; // 32 bit number 0x80000000

   reg [7:0] str[1:3];  // typing in 2 chars at a time (decimal # and Enter Key)
   reg[4:0] d1, d2, sum; // 5-bit X, Y to sum
   
   initial begin

      $display("Enter Two Digit Number (00~31):");

      d1 = $fgetc( STDIN );      // get first character.  
      d2 = $fgetc( STDIN );      // get second character.

      d1 = d1 - 48;               // convert ASCII representation to integer.
      d2 = d2 - 48;               // convert ASCII representation to integer.

      d1 = d1 * 10;
      sum = d1 + d2;

      $display("Got: %d", sum); // show its decimal value

   
    end
endmodule
