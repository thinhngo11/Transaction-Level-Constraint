class my_driver extends uvm_driver #(my_item);
  `uvm_component_utils(my_driver)
  
  virtual my_if vif;
  
  function new(string name="my_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
      `uvm_fatal("VIF", "can't get vif")
  endfunction
      
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      @(posedge vif.clk);
      $strobe("Driver: before getting item");
      seq_item_port.get_next_item(req);
      req.m_print("DRIVER");
      $strobe("Driver: after getting item: delay = %d", req.m_get_delay());
      repeat (req.m_get_delay()) @(vif.clk);
      vif.reset = req.m_get_reset();
      vif.enable = req.m_get_enable();
      vif.d = req.m_get_d(); 
      $strobe("Driver: before item done");
      seq_item_port.item_done();
      $strobe("Driver: after item done");
    end
  endtask
endclass
