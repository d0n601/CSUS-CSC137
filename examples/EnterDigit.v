// EnterDigit.v
// enter a single decimal digit 0 ~ 9, one at a time
// to compile: ~changw/ivl/bin/iverilog EnterDigit.v


module EnterDigit;
// stdin is given by default, console input (keyboard)
   parameter STDIN = 32'h8000_0000; // 32 bit number 0x80000000

   reg [7:0] x, newline;
   
   always begin // enter 0~9 in loop until entering other
      #1;       // always-loop requires time/event condition

      $display("Enter a single decimal digit, others to end:");

      x = $fgetc( STDIN );      // get ASCII order/value
      x = x - 48;               // convert to its meant value (0~9)

      $display("Got x: %d", x); // show its decimal value

      if( x > 9 ) begin         // not a digit entered
         $display("You no fun. Bye, bye!");
         $finish;
      end

      newline = $fgetc( STDIN );    // get newline, discard
   end
endmodule
