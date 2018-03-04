// EnterStr.v, test stdin input with multiple characters

module EnterStrMod;
   parameter STDIN = 32'h8000_0000; // 32 bit number 0x80000000

   reg [7:0] x;
   
   initial $display("Enter a string:");

   always begin // loop will auto pick up keyboard buffer
      #1;       // 'always' loop needs a time/event constraint
      x = $fgetc(STDIN);
      if(x == 10) $finish; // ENTER key, time to finish
      $display("%c = ASCII %d", x, x);
   end
endmodule
