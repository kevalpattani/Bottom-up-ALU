`timescale 1ns / 1ps

module booth_algo (input logic[31:0] a,b,
                  output logic[63:0]c);
                  
logic[31:0] m;
logic[31:0] q [32:0]; 
logic ql [32:0];
logic[31:0] fh_a [32:0]; // firstHalf_A
logic[31:0] a_not;
logic[31:0] b_not;
logic carry;

genvar i;

CLA a_change(.a(a),.b(32'b0),.carry_cin(1'b0),.sum_cla(a_not),.carry_cla(carry));
CLA b_change(.a(b),.b(32'b0),.carry_cin(1'b0),.sum_cla(b_not),.carry_cla(carry));

always_comb
begin
    fh_a[0] <= 32'b0;
    ql[0] <= 1'b0;
    if (a[31] == 1 & b[31] == 1) 
    begin
        m <= a_not;
        q[0] <= b_not;
    end
    else if (a[31] == 0 & b[31] == 1)
    begin
        m <= b;
        q[0] <= a; 
    end
    else if (a[31] == 1 & b[31] == 0)
    begin
        m <= a;
        q[0] <= b;
    end
    else if (a[31] == 0 & b[31] == 0)
    begin
        m <= a;
        q[0] <= b;
    end
    else 
    begin
        c <= 64'b0; 
    end
end    

generate
    for (i = 0; i < 32; i = i + 1) begin
        booth_checker block(.m(m),.q(q[i]),.fh_a(fh_a[i]),.ql(ql[i]),.qo(q[i+1]),.fh_ao(fh_a[i+1]),.qlo(ql[i+1]));
    end
endgenerate     

assign c = {fh_a[32],q[32]};                          
                  
endmodule
