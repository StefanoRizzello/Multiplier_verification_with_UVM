class packet_in extends uvm_sequence_item;
   rand longint A;
   rand longint B;

   constraint a_constraint { 
      A inside {[100:1000]}; 
      B > 0;
      B < A/10;
      }
   
   
    `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_in");
        super.new(name);
    endfunction: new
endclass: packet_in
