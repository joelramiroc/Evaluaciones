    module MultS4Bits(
        input [3:0] x,
        input [3:0] y,
        output [7:0] prod
    );

        wire [3:0] signx;
        wire [3:0] signy;
        wire [3:0] offsetx;
        wire [3:0] offsety;
        wire [3:0] xx;
        wire [3:0] yy;

        assign signx[3] = x[3];
        assign signx[2] = 1'b0;
        assign signx[1] = 1'b0;
        assign signx[0] = 1'b0;

        assign signy[3] = y[3];
        assign signy[2] = 1'b0;
        assign signy[1] = 1'b0;
        assign signy[0] = 1'b0;

        assign offsetx[3] = !x[3];
        assign offsetx[2] = !x[2];
        assign offsetx[1] = !x[1];
        assign offsetx[0] = !x[0];
        
        assign xx = offsetx + 1'b1;

        assign offsety[3] = !y[3];
        assign offsety[2] = !y[2];
        assign offsety[1] = !y[1];
        assign offsety[0] = !y[0];

        assign yy = offsety + 1'b1;

        wire [7:0] signxsigny;

        MultU4Bits multU4Bits(.x(signx), .y(signy), .prod(signxsigny));

        wire[7:0] signyoffsetx;
        wire[7:0] signxoffsety;
        wire[7:0] offsetxoffsety;
        wire[3:0] offsetyC;
        wire[3:0] offsetxC;
        wire[3:0] xxc;
        wire[3:0] yyc;
        
        
        assign offsetxC[3] = !xx[3];
        assign offsetxC[2] = !xx[2];
        assign offsetxC[1] = !xx[1];
        assign offsetxC[0] = !xx[0];
        
        assign offsetyC[3] = !yy[3];
        assign offsetyC[2] = !yy[2];
        assign offsetyC[1] = !yy[1];
        assign offsetyC[0] = !yy[0];

        assign xxc = offsetxC + 1'b1;
        assign yyc = offsetyC + 1'b1;


        
        MultU4Bits multU4Bits1(.x(signx), .y(yyc), .prod(signxoffsety));
        MultU4Bits multU4Bits2(.x(signy), .y(xxc), .prod(signyoffsetx));
        MultU4Bits multU4Bits3(.x(offsetx), .y(offsety), .prod(offsetxoffsety));


        assign prod = signxsigny + signxoffsety + signyoffsetx + offsetxoffsety;


    endmodule

    module MultU4Bits (
        input [3:0] x,
        input [3:0] y,
        output [7:0] prod
    );
        wire [3:0] pp[0:3];

        genvar i;
        generate
            for (i = 0; i < 4; i = i+1)
            begin
            assign pp[i] = {4{y[i]}} & x;
            end
        endgenerate

        wire [5:0] sum0;
        wire [5:0] sum1;
        
        assign sum0 = {1'b0, pp[0]} + {pp[1], 1'b0};
        assign sum1 = {1'b0, pp[2]} + {pp[3], 1'b0};

        assign prod = {2'b00, sum0} + {sum1, 2'b00};
    endmodule
