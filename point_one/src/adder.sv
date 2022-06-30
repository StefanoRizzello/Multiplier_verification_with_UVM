module adder(   input logic [63:0] A, B, 
                output logic [63:0] OUT );

    assign OUT = A + B;

endmodule: adder
