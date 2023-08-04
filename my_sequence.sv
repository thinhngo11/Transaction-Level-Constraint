class my_sequence extends uvm_sequence #(my_item);
  `uvm_object_utils(my_sequence)
  
  typedef enum { SMALL, ZERO, BIG} t_itemtype;
  typedef randomizetype;
  t_itemtype m_itemtype;
  my_itemSD reqSD;
  my_itemBD reqBD;
  my_itemZD reqZD;
  randomizetype m_randtype;
  
  function new(string name="");
    super.new(name);
    reqSD = new();
    reqBD = new();
    reqZD = new();
    m_randtype = new();
  endfunction
  
  virtual task body();
    repeat (50) begin
      if (!reqZD.randomize()) $dispaly("Can't randomize reqZD");
      if (!reqSD.randomize()) $display("Can't randomize reqSD");
      if (!reqBD.randomize()) $display("Can't randomize reqBD");
      //d::randomize(m_itemtype);
      m_randtype.randomize();
      m_itemtype = m_randtype.gettype();
      $display("m_itemtype=%s", m_itemtype.name());
      case (m_itemtype)
        SMALL: begin req = reqSD; req.m_print("SMALL"); end
        BIG: begin req = reqBD; req.m_print("BIG"); end
        ZERO: begin req = reqZD; req.m_print("ZERO"); end
      endcase
      //if (!req.randomize()) `uvm_error("MYERR", "Can't randomize req");
      req.m_print("SEQ");
      start_item(req);
      finish_item(req);
    end
  endtask
  
  class randomizetype;
    rand t_itemtype m_itemtype; 
    //consraint of transaction types
    constraint c_itemtype {
      m_itemtype dist { SMALL := 1, ZERO := 2, BIG := 3};
    }
      function t_itemtype gettype();
        return m_itemtype;
      endfunction
  endclass
endclass
