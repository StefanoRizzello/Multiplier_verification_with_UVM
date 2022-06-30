interface dut_if(input clk, rst);
    logic [63:0] A, B;
    logic [63:0] data;
    logic valid, ready;
    
    modport port_in (input clk, rst, A, B, valid, output ready);
    modport port_out (input clk, rst, output valid, data, ready);
endinterface

