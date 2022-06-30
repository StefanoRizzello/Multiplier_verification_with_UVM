class packet_in extends uvm_sequence_item;
    rand bit [31:0] A;
    rand bit [31:0] B;
	rand bit sign_A;
    rand bit sign_B;
    rand bit [7:0] exponent_A;
    rand bit [7:0] exponent_B;
    rand bit [22:0] mantissa_A;
    rand bit [22:0] mantissa_B;

    //constraint exponent_range_A {exponent_A > 126; exponent_A < 128;}
    //constraint exponent_range_B {exponent_B > 126; exponent_B < 128;}
	constraint exponent_range_A {exponent_A > 100; exponent_A < 253;}
    constraint exponent_range_B {exponent_B > 100; exponent_B < 253;}
    constraint mantissa_A_range {mantissa_A < 2**21; mantissa_A > 2**20;}
    constraint mantissa_B_range {mantissa_B < 2**22; mantissa_B > 2**21;}

	//rand bit [31:0] A;
	//rand bit [31:0] B;
	//bit sign_A = 0;
	//bit sign_B = 0;
	//bit [7:0] exponent_A = 130;
	//bit [7:0] exponent_B = 130;
	//bit [22:0] mantissa_A = 0;
	//bit [22:0] mantissa_B = 0;
	
    constraint A_C {A == {sign_A, exponent_A, mantissa_A};}
    constraint B_C {B == {sign_B, exponent_B, mantissa_B};}

    `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_in");
        super.new(name);
    endfunction: new
endclass: packet_in
