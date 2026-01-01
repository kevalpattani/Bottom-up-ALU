`timescale 1ns / 1ps

module rotate_shift(input logic[31:0] a,b,
                    input logic side,
                    input logic[5:0] shift,
                    output logic[63:0] out);
                    
logic[63:0] pre_out;
logic[63:0] inter_out; 
logic[5:0] s;

always_comb
begin 
    
    inter_out = {a,b};
    s = shift % 64;
    
    if (side)
    begin
        pre_out <= (inter_out << s) | (inter_out >> (64-s));
    end
    else
    begin 
        pre_out <= (inter_out >> s) | (inter_out << (64-s));
    end
end          
         
assign out = pre_out;
                    
endmodule
