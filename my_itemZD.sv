class my_itemZD extends my_item;
  `uvm_object_utils(my_itemZD)

  constraint c_delay {delay == 0;}
  
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
    $display("my_itemZD: %s delay = %d", more, delay);
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
