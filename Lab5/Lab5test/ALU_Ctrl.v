`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */
wire [2:0] func3;
assign func3 = instr[2:0];

always @(*) begin
	/*if(ALUOp == 2'b00) begin 		//lw, sw, addi
		ALU_Ctrl_o <= 4'b0010; 
	end
	else if(ALUOp == 2'b01) begin 	//beq
		ALU_Ctrl_o <= 4'b0110; 
	end
	else if(ALUOp == 2'b10) begin	//R-type
		case(instr)
            4'b0000: begin              //add
                ALU_Ctrl_o <= 4'b0010;
			end
            4'b1000: begin              //sub
                ALU_Ctrl_o <= 4'b0110;
			end
            4'b0111: begin              //and
                ALU_Ctrl_o <= 4'b0000;
			end
            4'b0110: begin              //or
                ALU_Ctrl_o <= 4'b0001;
			end
            4'b0010: begin              //slt
                ALU_Ctrl_o <= 4'b0111;
			end
            4'b0100: begin              //xor
                ALU_Ctrl_o <= 4'b0011;
			end
            4'b0001: begin              //sll
                ALU_Ctrl_o <= 4'b1100; 
			end
			4'b1101: begin              //sra
                ALU_Ctrl_o <= 4'b1001;
			end
            default: begin
                ALU_Ctrl_o <= 4'b0000;
			end         
        endcase
	end
	else if(ALUOp == 2'b11) begin
		case(func3)
            3'b001: begin              //slli
                ALU_Ctrl_o <= 4'b1100;
			end
            3'b010: begin              //slti
                ALU_Ctrl_o <= 4'b0111;
			end
            3'b101: begin              //srli
                ALU_Ctrl_o <= 4'b1000;
			end       
        endcase
	end
	else begin
		ALU_Ctrl_o <= 4'b1111;
	end*/

    case(ALUOp)
        2'b00://lw sw => add
            ALU_Ctrl_o <= 4'b0010;
        2'b01://branch => sub
            ALU_Ctrl_o <= 4'b0110;
        2'b10://R-type
            begin
               
                case(instr)
                    4'b0000://add
                        ALU_Ctrl_o <= 4'b0010;
                    4'b1000://sub
                        ALU_Ctrl_o <= 4'b0110;
                    4'b0111://and
                        ALU_Ctrl_o <= 4'b0000;
                    4'b0110://or
                        ALU_Ctrl_o <= 4'b0001;
                    4'b0010://slt
                        ALU_Ctrl_o <= 4'b0111;
                    4'b0100://xor
                        ALU_Ctrl_o <= 4'b0011;
                    4'b0001: //sll
                        ALU_Ctrl_o <= 4'b1100; 
				    4'b1101: //sra
                        ALU_Ctrl_o <= 4'b1001; 
                    default:
                        ALU_Ctrl_o <= 4'b0000;
                    
                endcase
            
            end
        2'b11: 
            begin
                case(func3)
                    3'b001: //slli
                        ALU_Ctrl_o <= 4'b1100; 
                    3'b010: //slti
                        ALU_Ctrl_o <= 4'b0111; 
                    3'b101: //srli
                        ALU_Ctrl_o <= 4'b1000; 
                    3'b000: //addi => add
                        ALU_Ctrl_o <= 4'b0010; 
                
                endcase
            end
        default:
            ALU_Ctrl_o <= 4'b1111;

    endcase
end

endmodule
