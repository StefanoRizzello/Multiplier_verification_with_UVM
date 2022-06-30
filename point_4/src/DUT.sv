module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [3:0] {INITIAL,STAGE_1,STAGE_2,STAGE_3,STAGE_4,SEND} state);
    
    FPmul FPmul_under_test(.clk(in_inter.clk),.rst_n(in_inter.rst),.FP_A(in_inter.A),.FP_B(in_inter.B),.FP_Z(out_inter.data));
	
	shortreal A_variable;
	shortreal B_variable;
	

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
                    state <= STAGE_1;
                end
                
                STAGE_1: begin
                    if(in_inter.valid) begin
                        in_inter.ready <= 0;
                        out_inter.valid <= 0;
						A_variable = in_inter.A;
						B_variable = in_inter.B;
						//$display("STAGE 1 => fpmul: input A = %b, input B = %b, output OUT = %b", A_variable, B_variable, out_inter.data);
                    	//$display("STAGE 1 => fpmul: input A = %e, input B = %e, OUT_f = %e", $bitstoshortreal(A_variable), $bitstoshortreal(B_variable),$bitstoshortreal(out_inter.data));
                        state <= STAGE_2;
                    end
                end
                
                STAGE_2: begin
					//$display("STAGE 2 => fpmul: input A = %b, input B = %b, output OUT = %b", A_variable, B_variable, out_inter.data);
                    //$display("STAGE 2 => fpmul: input A = %e, input B = %e, OUT_f = %e", $bitstoshortreal(A_variable), $bitstoshortreal(B_variable),$bitstoshortreal(out_inter.data));
                    state <= STAGE_3;
                end
                
                STAGE_3: begin
					//$display("STAGE 3 => fpmul: input A = %b, input B = %b, output OUT = %b", A_variable, B_variable, out_inter.data);
                    //$display("STAGE 3 => fpmul: input A = %e, input B = %e, OUT_f = %e", $bitstoshortreal(A_variable), $bitstoshortreal(B_variable),$bitstoshortreal(out_inter.data));
                    state <= STAGE_4;
                end
                
                STAGE_4: begin
                    out_inter.valid <= 1;
					//$display("STAGE 4 => fpmul: input A = %b, input B = %b, output OUT = %b", A_variable, B_variable, out_inter.data);
                    //$display("STAGE 4 => fpmul: input A = %e, input B = %e, OUT_f = %e", $bitstoshortreal(A_variable), $bitstoshortreal(B_variable), $bitstoshortreal(out_inter.data));
					$display("fpmul: input A = %b, input B = %b, output OUT = %b", A_variable, B_variable, out_inter.data);
                    $display("fpmul: input A = %e, input B = %e, OUT_f = %e", $bitstoshortreal(A_variable), $bitstoshortreal(B_variable), $bitstoshortreal(out_inter.data));
					state <= SEND;
                end
                
                SEND: begin
                    if(out_inter.ready) begin
                        in_inter.ready <= 1;
                        out_inter.valid <= 0;
                        state <= STAGE_1;
                    end
                end
        endcase
    end
endmodule: DUT
