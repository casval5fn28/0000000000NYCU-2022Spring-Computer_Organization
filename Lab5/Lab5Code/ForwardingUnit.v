`timescale 1ns/1ps
module ForwardingUnit (
    input [5-1:0] IDEXE_RS1,
    input [5-1:0] IDEXE_RS2,
    input [5-1:0] EXEMEM_RD,
    input [5-1:0] MEMWB_RD,
    input EXEMEM_RegWrite,
    input MEMWB_RegWrite,
    output reg [2-1:0] ForwardA,
    output reg [2-1:0] ForwardB
);
/* Write your code HERE */
always @(*) begin
	//A
    if(EXEMEM_RegWrite==1'b1 && EXEMEM_RD != 0 && IDEXE_RS1 == EXEMEM_RD )begin
        ForwardA <= 2'b10;            //alu_src1 = result
    end else if((MEMWB_RegWrite == 1) && (MEMWB_RD != 0) && ~(EXEMEM_RegWrite) && (EXEMEM_RD != 0) && (EXEMEM_RD != IDEXE_RS1)) begin
        ForwardA <= 2'b01;            //alu_src1 = MUXMemtoReg_o
    end else begin 
        ForwardA <= 2'b00;            //alu_src1 = rt or imm
    end
    
	//B
    if(EXEMEM_RegWrite==1'b1 && EXEMEM_RD != 0 && IDEXE_RS2 == EXEMEM_RD )begin
        ForwardB <= 2'b10;            //alu_src2 = result
    end else if((MEMWB_RegWrite == 1) && (MEMWB_RD != 0) && ~(EXEMEM_RegWrite) && (EXEMEM_RD != 0) && (EXEMEM_RD != IDEXE_RS2)) begin
        ForwardB <= 2'b01;            //alu_src2 = MUXMemtoReg_o
    end else begin
        ForwardB <= 2'b00;            //alu_src2 = rt or imm
    end
end

endmodule

