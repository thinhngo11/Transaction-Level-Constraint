class my_coverage extends uvm_subscriber #(my_item);
  `uvm_component_utils(my_coverage)
  uvm_analysis_imp #(my_item, my_coverage) m_export;
  my_item m_item;
  
  covergroup Cov;
    option.per_instance = 1;
    cp_reset: coverpoint m_item.reset;
    cp_enable: coverpoint m_item.enable;
    cp_d : coverpoint m_item.d;
    cc_all: cross cp_reset, cp_enable, cp_d;
  endgroup
    
  function new(string name="my_scoreboard", uvm_component parent);
    super.new(name, parent);
    Cov = new();
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_export = new("m_export", this);
  endfunction 
  
  virtual function void write(my_item t);
    this.m_item = t;
    Cov.sample();
  endfunction
    
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("Coverage = %d", Cov.get_coverage());
  endfunction
endclass
