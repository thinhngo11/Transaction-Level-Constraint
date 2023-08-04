class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  
  my_agent m_agent;
  my_scoreboard m_scrb;
  my_coverage m_cov;
  
  uvm_analysis_port #(my_item) m_port;
  
  function new(string name="my_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_agent = my_agent::type_id::create("m_agent", this);
    m_scrb = my_scoreboard::type_id::create("m_scrb", this);
    m_cov = my_coverage::type_id::create("m_cov", this);
    m_port = new("m_port", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    m_agent.m_mon.m_port.connect(m_scrb.m_export);
    m_agent.m_mon.m_port.connect(m_cov.m_export);
  endfunction
endclass
