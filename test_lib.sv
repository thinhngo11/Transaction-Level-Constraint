// test library
  import uvm_pkg::*;
`include "uvm_macros.svh"
class my_base_test extends uvm_test;

  `uvm_component_utils(my_base_test)
  my_env m_env;   
  function new(string name="my_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_env = my_env::type_id::create("m_env", this);
    // Set the default sequence for the master and slave.
    //uvm_config_db#(uvm_object_wrapper)::set(this,
    //"m_env.m_agent.m_sequencer.main_phase", "default_sequence",
    //my_sequence::type_id::get());
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    my_sequence m_sequence =  	 	
    my_sequence::type_id::create("m_sequence");
    m_sequence.randomize();
    phase.raise_objection(this);
    m_sequence.start(m_env.m_agent.m_sequencer);
    phase.drop_objection(this);
  endtask
  
endclass 
 
