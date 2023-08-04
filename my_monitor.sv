class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)
  uvm_analysis_port #(my_item) m_port;
  my_item m_item;
  
  virtual my_if vif;

  function new(string name="my_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_port = new("m_port", this);
    if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
      `uvm_fatal("VIF", "can't get vif")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    m_item = my_item::type_id::create("m_item");
    
    forever begin
      @(posedge vif.clk);
      m_item.reset = vif.reset;
      m_item.enable = vif.enable;
      m_item.d = vif.d;
      m_item.q = vif.q;
      m_port.write(m_item);
    end
  endtask
endclass
