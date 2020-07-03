module Main(
    input clk,
    input rst,
    input [31:0] a,
    input [31:0] b
);

    // Wires
    wire is_zero_result;
    wire [4:0] rf_read_addr1;
    wire [4:0] rf_read_addr2;
    wire [4:0] rf_write_addr;
    wire rf_write_en;
    wire rf_write_data_sel;
    wire [31:0] const_val;
    wire alu_sel;
    wire [1:0] alu_oper;

    GcdFSM fsm (
        .clk( clk ),
        .rst( rst ),
        .a( a ),
        .b( b ),
        .is_zero_result( is_zero_result ),
        .rf_read_addr1( rf_read_addr1 ),
        .rf_read_addr2( rf_read_addr2 ),
        .rf_write_addr( rf_write_addr ),
        .rf_write_en( rf_write_en ),
        .rf_write_data_sel( rf_write_data_sel ),
        .const_val( const_val ),
        .alu_sel( alu_sel ),
        .alu_oper( alu_oper )
    );

    GPPM gppm (
        .clk( clk ),
        .rf_read_addr1( rf_read_addr1 ),
        .rf_read_addr2( rf_read_addr2 ),
        .rf_write_addr( rf_write_addr ),
        .rf_write_en( rf_write_en ),
        .rf_write_data_sel( rf_write_data_sel ),
        .const_val( const_val ),
        .alu_sel( alu_sel ),
        .alu_oper( alu_oper ),
        .is_zero_result( is_zero_result )
    );

endmodule