module GPPM(
    input clk,
    input [4:0] rf_read_addr1,
    input [4:0] rf_read_addr2,
    input [4:0] rf_write_addr,
    input rf_write_en,
    input rf_write_data_sel,
    input [31:0] const_val,
    input alu_sel,
    input [1:0] alu_oper,
    output is_zero_result
);
    // Register file signals
    wire [31:0] rf_read_data1;
    wire [31:0] rf_read_data2;
    wire [31:0] rf_write_data;

    // ALU wires
    wire [31:0] alu_result;
    wire [31:0] alu_second_operand;

    // Muxes
    assign rf_write_data = (rf_write_data_sel)? const_val : alu_result;
    assign alu_second_operand = (alu_sel)? const_val : rf_read_data2;

    RegFile #(.ADDR_BITS(5)) reg_file
    (
        .clk( clk ),
        .read_addr1( rf_read_addr1 ),
        .read_addr2( rf_read_addr2 ),
        .write_addr( rf_write_addr ),
        .write_en( rf_write_en ),
        .write_data( rf_write_data ),
        .read_data1( rf_read_data1 ),
        .read_data2( rf_read_data2 )
    );

    ALU alu (
        .op1( rf_read_data1 ),
        .op2( alu_second_operand ),
        .oper( alu_oper ),
        .result( alu_result ),
        .is_zero( is_zero_result )
    );

endmodule