`timescale 1ns / 1ps

module booth_checker(input logic[31:0]m,q,fh_a,
                     input logic ql,
                     output logic[31:0]qo,fh_ao,qlo);
           
logic[31:0] interstate;
logic carry_in;
logic carry_out;
logic[31:0] adder_b;
                     
always_comb
begin 

adder_b <= 32'b0;
carry_in <= 1'b0;

if (q[0] == 0 & ql == 1)
begin 
adder_b <= m;
carry_in <= 1'b0;
end
else if (q[0] == 1 & ql == 0)
begin
adder_b <= ~m;
carry_in <= 1'b1;
end
else
begin
adder_b <= 32'b0;
carry_in <= 1'b0;
end
end

CLA calculation(.a(fh_a),.b(adder_b),.carry_cin(carry_in),.sum_cla(interstate),.carry_cla(carry_out));

always_comb
begin
qlo <= q[0];
fh_ao <= $signed(interstate) >>> 1;
// why do I put signed here before the interstate? beacause referring to the IEEE Std 1800-2017 section 11.4.10 Shift operators I found that all the arithmetic operations that are intended to copy the MSB or LSB should be signed as mentioned for the opposite "The arithmetic right shift shall fill the vacated bit positions with zeros if the result type is unsigned", I leant that it is always better to go with cross checking of the rules rather than making a logical assumption that can fail. 
qo <= {interstate[0],q[31:1]};
end
                
endmodule
