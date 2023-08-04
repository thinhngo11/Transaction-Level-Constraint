class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
  uvm_analysis_imp #(my_item, my_scoreboard) m_export;
  my_item m_item_prev;

  function new(string name="my_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_export = new("m_export", this);
  endfunction 
  
  virtual function void write(my_item m_item);
    if (m_item_prev == null) begin
      m_item_prev = my_item::type_id::create("m_item_prev");
      m_item_prev.do_copy(m_item);
    end
    else begin
      if (m_item.q != m_item_prev.reset? 1'b0 : m_item_prev.enable? m_item_prev.d : m_item_prev.q)`uvm_error("SCRB", "q not correct")
        m_item_prev.do_copy(m_item);
    end
  endfunction
endclass
