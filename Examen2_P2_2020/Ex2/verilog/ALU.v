module ALU(
    input [31:0] op1,
    input [31:0] op2,
    input [1:0] oper,
    output reg [31:0] result,
    output is_zero
);

    assign is_zero = ~|result;

    always @ (*)
    begin
        case (oper)
            2'd0: result = op1 + op2;
            2'd1: result = op1 - op2;
            2'd2: result = op1 * op2;
            2'd3: result = {31'h0, $signed(op1) < $signed(op2)};
            default:
                result = 32'dx;
        endcase
    end

endmodule