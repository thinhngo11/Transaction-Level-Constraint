`include "my_if.sv"
`include "my_pkg.pkg"
module tb_top;
  import my_pkg::*;
  `include "test_lib.sv"
  
  bit clk, reset, d, enable, q, qbar;
  
  my_if vif();
  
  my_dut dut (.clk(vif.clk), .reset(vif.reset), .d(vif.d), 
              .enable(vif.enable), .q(vif.q));
  
  always #5 vif.clk = ~vif.clk;
  
  initial vif.clk = 1'b0;
  
  initial begin
    uvm_config_db#(virtual my_if)::set(null, "*", "vif", vif);
    run_test("my_base_test");
  end
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);
  end
endmodule
