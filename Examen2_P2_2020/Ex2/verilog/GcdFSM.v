module GcdFSM(
    input clk,
    input rst,
    input [31:0] a,
    input [31:0] b,
    input is_zero_result,
    output reg [4:0] rf_read_addr1,
    output reg [4:0] rf_read_addr2,
    output reg [4:0] rf_write_addr,
    output reg rf_write_en,
    output reg rf_write_data_sel,
    output reg [31:0] const_val,
    output reg alu_sel,
    output reg [1:0] alu_oper
);

    wire [31:0] rf_write_data;

    wire [31:0] alu_result;
    wire [31:0] alu_second_operand;
    wire [31:0] rf_read_data1;
    wire [31:0] rf_read_data2;

    assign rf_write_data = (rf_write_data_sel)? const_val : alu_result;
    assign alu_second_operand = (alu_sel)? const_val : b;



  RegFile #(.ADDR_BITS(5)) reg_file
    (
        .clk( clk ),
        .read_addr1( rf_read_addr1 ),
        .read_addr2( rf_read_addr2 ),
        .write_addr( 5'd0 ),
        .write_en( rf_write_en ),
        .write_data( rf_write_data ),
        .read_data1( rf_read_data1 ),
        .read_data2( rf_read_data2 )
    );
    
    ALU alu (
        .op1( a ),
        .op2( alu_second_operand ),
        .oper( alu_oper ),
        .result( alu_result ),
        .is_zero( is_zero_result )
    );

endmodule