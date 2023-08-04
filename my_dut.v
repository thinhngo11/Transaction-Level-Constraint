//synchronous d-flip-flop w/ enable
module my_dut (input clk, reset, d, enable, output q);
  reg qreg;
  always @(posedge clk)
    if (reset) 
      qreg <= 1'b0;
    else if (enable)
      qreg <= d;
    else 
      qreg <= qreg;
  
  assign q = qreg;
endmodule
