`timescale 1ns / 1ps

module non_restoring_div(input logic[31:0] a,b,
                         output logic [63:0] out,
                         output logic sign_check);
   
logic [31:0] inv_a;
logic [31:0] inv_b;
logic carry_a;
logic carry_b;
logic [31:0] calc_a[32:0];
logic [31:0] calc_b; 
logic carry_not_used; 
genvar i; 
logic isneg;
logic [31:0] accumulator[32:0];
logic [31:0] last_a_check;
logic [31:0] quotient; 
                         
always_comb
begin
    accumulator[0] <= 32'b0;
    if (a[31] == 0 & b[31] == 1)
    begin
        inv_a <= a;
        inv_b <= ~b;
        carry_a <= 1'b0;
        carry_b <= 1'b1;
        isneg <= 1'b1;
    end 
    else if (a[31] == 1 & b[31] == 0)   
    begin 
        inv_a <= ~a;
        inv_b <= b;
        carry_a <= 1'b1;
        carry_b <= 1'b0;   
        isneg <= 1'b1;
    end
    else if (a[31] == 1 & b[31] == 1)
    begin
        inv_a <= ~a;
        inv_b <= ~b;
        carry_a <= 1'b1;
        carry_b <= 1'b1;
        isneg <= 1'b0;
    end 
    else
    begin
        inv_a <= a;
        inv_b <= b;
        carry_a <= 1'b0;
        carry_b <= 1'b0;
        isneg <= 1'b0;
    end
end                
              
CLA a_val(.a(inv_a),.b(32'b0),.carry_cin(carry_a),.sum_cla(calc_a[0]),.carry_cla(carry_not_used));
CLA b_val(.a(32'b0),.b(inv_b),.carry_cin(carry_b),.sum_cla(calc_b),.carry_cla(carry_not_used));

generate
    for(i=0;i<32;i++) begin
        non_restoring_block compute(.M(calc_b),.Q(calc_a[i]),.A(accumulator[i]),.UQ(calc_a[i+1]),.UA(accumulator[i+1]));    
    end
endgenerate

always_comb
begin
    if (accumulator[32][31] == 1)
    begin
        last_a_check <= b;
    end
    else
    begin
        last_a_check <= 32'b0;
    end
end

CLA final_a_calc(.a(accumulator[32]),.b(last_a_check),.carry_cin(1'b0),.sum_cla(quotient),.carry_cla(carry_not_used));

assign out = {quotient[31:0],calc_a[32][31:0]};
assign sign_check = isneg;
                         
endmodule
