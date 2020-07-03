module MicroHondas
(
    input clk,
    input rst,
    input [7:0] minuto,
    input enabled,
    output [7:0] r1,
    output [7:0] r2,
    output [7:0] r3,
    output [7:0] r4
);

    parameter q0 = 3'd0;
    parameter q1 = 3'd1;
    parameter q2 = 3'd2;
    parameter q3 = 3'd3;
    parameter q4 = 3'd4;
    parameter q5 = 3'd5;
    parameter q6 = 3'd6;

    reg [7:0] a, b;
    reg [7:0] snA, snB;

    reg [2:0] cs;
    reg [2:0] ns;

    ConvertToBits cc1(.number(a >8'd0? a- 8'd1 : a), .n1(r1), .n2(r2));
    ConvertToBits cc2(.number(a >8'd0? b : 8'd0), .n1(r3), .n2(r4)); 

always @(*)
begin
   case(cs)

            q0: begin 
                ns = q1;            
            end

            q1: begin
                ns = a!= 8'd0? q2:q6;
            end
            
            q2: begin
                ns = q3;
            end
            
            q3: begin
                ns = b!=8'd0? q2:q4;
            end
            
            q4: begin
                ns = q5;
            end
            
            q5: begin
                ns = a!= 8'd0? q2:q6;
            end
            
            q6: begin
                ns = q6;
            end

            default: begin
                ns = q0; 
            end
        endcase
end

     //Outputs 
    always @(*) begin

        if (enabled) begin
        case(cs)

            q0: begin
                snA = minuto;  
                snB = 8'd60;              
            end

            q1: begin
                snA = a;  
                snB = b; 
            end
            
            q2: begin
                snA = a;  
                snB = b - 8'd1; 
            end
            
            q3: begin
                snA = a;  
                snB = b; 
            end
            
            q4: begin
                snA = a- 8'd1;  
                snB = 60; 
            end
            
            q5: begin
                snA = a;  
                snB = b; 
            end
            
            q6: begin
                snA = a;  
                snB = b; 
            end

            default: begin
                snA = 8'd0;  
                snB = 8'd0; 
            end
        endcase 
        end
    end


    //current state
    always @(posedge clk) begin
        if(rst)
            cs <= q0;
        else 
            cs <= ns;
    end

    always @(posedge clk) begin
        a <= snA;
        b <= snB;
    end

endmodule


module ConvertToBits(
    input [7:0] number,
    output [7:0] n1,
    output [7:0] n2
);

    reg [7:0] contador;
    reg [7:0] comparador;
    reg [7:0] resultBt1;
    reg [7:0] resultBt2;

    Get7ComplementinBits t1(.number(resultBt1), .value(n1));
    Get7ComplementinBits t2(.number(resultBt2), .value(n2));

     always @(*) 
        begin
            comparador = number;
            if (comparador < 10) begin
                resultBt1 = 8'b0;
                resultBt2 = comparador;
            end
            else        
            begin
                contador = 4'b0;
                while(comparador >= 10)
                begin
                    contador = contador + 4'd1;
                    comparador = comparador - 10;
                end
                resultBt1 = contador;
                resultBt2 = comparador;
            end
        end
        

endmodule

//  Modulo para generar digito

module Get7ComplementinBits(
        input [7:0] number,
        output [7:0] value
        );

        reg [7:0] resultBt;
        assign value = resultBt;
        
        always @(*)
        begin
            case (number)
                    0: resultBt <= 8'b11111100;
                    1: resultBt <= 8'b01100000;
                    2: resultBt <= 8'b11011010;
                    3: resultBt <= 8'b11110010;
                    4: resultBt <= 8'b01100110;
                    5: resultBt <= 8'b10110110;
                    6: resultBt <= 8'b00111110;
                    7: resultBt <= 8'b11100000;
                    8: resultBt <= 8'b11111110;
                    9: resultBt <= 8'b11100110;
                    default: resultBt <= 8'b00000000;
                endcase
        end

    endmodule   