`timescale 1ns/1ps

module Decoder(
    input [32-1:0]  instr_i,
    input branch_i,
    output reg         Branch,
    output reg         ALUSrc,
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg,
    output reg         Jump,
    output reg         Flush
);


//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

/* Write your code HERE */
assign opcode = instr_i[6:0];
assign funct3 = opcode[14:12];

always@ (*) begin
    Flush <= Branch || Jump;
    Branch <= ((opcode[6:0]==7'b1100011) && branch_i==1'b1)? 1:0;
    case(opcode)
		7'b0110011: begin   //R-type
			RegWrite <= 1;
			//Branch <= 0;
            Jump <= 0;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUSrc <= 0;
			ALUOp <= 2'b10;
		end
        7'b0010011: begin   //I-type: addi, slti, slli
			RegWrite <= 1;
			//Branch <= 0;
            Jump <= 0;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUSrc <= 1;
			ALUOp <= 2'b11;
		end
		7'b0000011: begin   //lw
			RegWrite <= 1;
			//Branch <= 0;
            Jump <= 0;
            MemtoReg <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            ALUSrc <= 1;
			ALUOp <= 2'b00;
		end
		7'b0100011: begin   //sw
			RegWrite <= 0;
			//Branch <= 0;
            Jump <= 0;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            ALUSrc <= 1;
			ALUOp <= 2'b00;
		end
		7'b1100011: begin   //Branch
			RegWrite <= 0;
			//Branch <= 1;
            Jump <= 0;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUSrc <= 0;
			ALUOp <= 2'b01;
		end
        7'b1101111: begin   //jal
			RegWrite <= 1;
			//Branch <= 0;
            Jump <= 1;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUSrc <= 0;
			ALUOp <= 2'b00;
		end
        7'b1100111: begin   //jalr
			RegWrite <= 1;
			//Branch <= 0;
            Jump <= 1;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUSrc <= 0;
			ALUOp <= 2'b00;
		end
        default: begin
            RegWrite <= 1;
			//Branch <= 0;
            Jump <= 0;
            MemtoReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            ALUSrc <= 1;
			ALUOp <= 2'b11;
        end
	endcase
    
end

endmodule









