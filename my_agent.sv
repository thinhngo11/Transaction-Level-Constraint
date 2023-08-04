class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
   my_monitor m_mon;
   my_driver m_driver;
   uvm_sequencer #(my_item) m_sequencer;
  
  function new(string name="my_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_mon = my_monitor::type_id::create("m_mon", this);
    m_driver = my_driver::type_id::create("m_driver", this);
    //m_sequencer = new("m_sequencer");
    m_sequencer = uvm_sequencer#(my_item)::type_id::create("m_sequencer", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  endfunction
endclass

  
  
