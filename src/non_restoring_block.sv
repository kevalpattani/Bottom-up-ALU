`timescale 1ns / 1ps

module non_restoring_block(input logic[31:0] M,Q,A,
                           output logic[31:0] UQ,UA);

logic [31:0] inter_A;
logic [31:0] final_A;
logic [31:0] inter_M;
logic carry;
logic carry_unused;
                           
always_comb
begin
    inter_A <= {A[30:0],Q[31]};
    
    if (inter_A[31] == 0)
    begin
        inter_M <= ~M;  
        carry <= 1'b1;       
    end 
    else if (inter_A[31] == 1)
    begin
        inter_M <= M;
        carry <= 1'b0;
    end
end                          
     
CLA calculation(.a(inter_A),.b(inter_M),.carry_cin(carry),.sum_cla(final_A),.carry_cla(carry_unused));

always_comb
begin
    UA <= final_A;
    if (final_A[31] == 1)
    begin
        UQ <= {Q[30:0],1'b0};
    end
    else if (final_A[31] == 0)
    begin
        UQ <= {Q[30:0],1'b1};
    end
end
                          
endmodule
