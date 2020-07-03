module RegFile #(
    parameter ADDR_BITS = 3
)
(
    input clk,
    input [(ADDR_BITS-1):0] read_addr1,
    input [(ADDR_BITS-1):0] read_addr2,
    input [(ADDR_BITS-1):0] write_addr,
    input write_en,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    
    reg[31:0] regs[0:((1 << ADDR_BITS)-1)] /*verilator public*/;
    
    assign read_data1 = regs[read_addr1];
    assign read_data2 = regs[read_addr2];
        
    always @ (posedge clk)
    begin
        if (write_en)
            regs[write_addr] <= write_data;
    end

endmodule
