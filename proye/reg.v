module regFile(
    input [1:0] ra,
    input [1:0] wa,
    input we,
    input clk,
    input [31:0] wd,
    output [31:0] rd
);

    reg[31:0] regs[0:3];

    assign rd = regs[ra];

    always @(posedge clk)
    begin
       regs[wa] = wd;
    end
endmodule

module#(
    parameter ADD_BITS = 3;
) regFileGeneric(
    input [ADD_BITS:0] ra,
    input [ADD_BITS:0] ra2,
    input [ADD_BITS:0] wa,
    input [ADD_BITS:0] wa2,
    input we,
    input clk,
    input [31:0] wd,
    input [31:0] wd2,
    output [31:0] rd
);

    reg[31:0] regs[0:((1<< ADD_BITS) - 1)];
    assign rd = regs[ra];
    assign rd2 = regs[ra2];

    always @(posedge clk)
    begin
        if (we) begin
            regs[wa] = wd;
            regs[wa2] = wd2;
        end
    end
endmodule


regFileGeneric reg(
    .ra(),
    .wa(),
    .we(),
    .wd(),
    .rd()
)

regFileGeneric #(.ADD_BITS(4)) reg(
    .ra(),
    .wa(),
    .we(),
    .wd(),
    .rd()
)



module ALU(
    input [31:0] op1,
    input [31:0] op2,
    input [1:0] oper,
    output [31:0] result,
    output zero
);

    assign zero = (result == 0);
    assign zero = ~|result;

    always @(*)
    begin
        case (oper)
            2'd0: result = op1 + op2;
            2'd1: result = op1 - op2;
            2'd2: result = op1 * op2;
            2'd3: result = $signed(op1) < $signed(op2); 
            default: result = 32'dx;
        endcase    
    end 

endmodule