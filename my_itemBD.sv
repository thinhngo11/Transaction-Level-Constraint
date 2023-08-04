class my_itemBD extends my_item;
  `uvm_object_utils(my_itemBD)
  rand logic reset;
  rand logic enable;
  rand logic d;
  logic q;
  rand int delay;
  
  constraint c_reset {reset dist {1:=1, 0:=5};}  
  constraint c_delay {delay > 3; delay <6;}
  
  function new(string name="");
    super.new(name);
  endfunction
  
  virtual function void do_copy(uvm_object rhs);
    my_item tx;
    $cast(tx, rhs);
    super.do_copy(rhs);
    reset = tx.reset;
    enable = tx.enable;
    d = tx.d;
    q = tx.q;
    delay = tx.delay;
  endfunction
  
  virtual function void m_print(string more);
    $display("my_itemBD: %s delay = %d", more, delay);
  endfunction
  
  virtual function int m_get_delay();
    return this.delay;
  endfunction
  virtual function logic m_get_reset();
    return this.reset;
  endfunction
  virtual function logic m_get_enable();
    return this.enable;
  endfunction
  virtual function logic m_get_d();
    return this.d;
  endfunction
endclass
