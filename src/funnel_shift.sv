`timescale 1ns / 1ps

module funnel_shift(input logic[31:0] a,b,
                    input logic side,
                    input logic[5:0] shift,
                    output logic[63:0] out);
                    
logic[63:0] pre_out;
logic[63:0] inter_out;                 
                                                                          
always_comb
begin 

    pre_out <= {a,b};

    if (side == 1)
    begin
        inter_out <= (pre_out) << shift[5:0];
    end
    else
    begin
        inter_out <= (pre_out) >> shift[5:0];
    end
end      

assign out = inter_out;              
                    
endmodule
