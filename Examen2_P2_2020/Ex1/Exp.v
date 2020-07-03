module Exp(
    input clk,
    input rst,
    input [31:0] x,
    input [31:0] n,
    output [31:0] res
);


    reg[31:0] xx, nn, y, r;
    reg[31:0] nx, nn, ny, nr;

    reg[3:0] cs;
    reg[3:0] ns;

    parameter q1 = 4'b0000;
    parameter q2 = 4'b0001;
    parameter q3 = 4'b0011;
    parameter q4 = 4'b0100;
    parameter q5 = 4'b0101;
    parameter q6 = 4'b0110;
    parameter q7 = 4'b0111;
    parameter q8 = 4'b1000;
    parameter q9 = 4'b1001;
    parameter q10 = 4'b1010;

    assign res = r;


    always @(*) begin

        case(cs)

            q1: begin
                nr = 32'd0;
                nx = x;
                nn = n;
                ny = 32'd1;
            end

            q9: begin
                nr = 32'd1;
            end

            q7: begin
                nx = xx * xx;
                nn = nn / 2;
            end

            q6: begin
                nx = xx * xx;
                nn = (nn - 1) / 2;
                ny = xx * y;
            end

            q8: begin
                nr = xx * y;
            end
        endcase

    end



    always @(*) begin

        case(cs)

            q1: ns = q2;

            q2: 
                if(nn == 0)
                    ns = q9;
                else
                    ns = q3;

            q3: ns = q4;

            q4: 
                if(nn > 1)
                    ns = q5;
                else
                    ns = q8;

            q5: 
                if((nn & 1) == 0)
                    ns = q7;
                else
                    ns = q6;
            q7: ns = q4;
            q6: ns = q4;
            q8: ns = q10;
            q9: ns = q10;
            q10: ns = q10;
        endcase

    end


    always @(posedge clk) begin
        xx <= nx;
        nn <= nn;
        y <= ny;
        r <= nr;
    end

    always @(posedge clk) begin
        cs <= (rst) ? 0 : ns;   
    end


endmodule