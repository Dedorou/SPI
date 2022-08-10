`timescale 1ns / 1ps

module sh_reg
#(
parameter command_read = 8'b00000011,
parameter command_write = 8'b00000010
)(
input data_in, 
input clk,
input rst,
output data_out);

reg [7:0] temp_reg =0;
reg [2:0] bit_counter =0;
reg flag = 1'b0;

always @(posedge clk or posedge rst)
begin : shifter 
		if (rst) begin //asynchronous reset
              temp_reg <= {8{1'b0}}; //load REG_DEPTH zeros
            end else begin
              temp_reg <= {temp_reg[6:0], data_in}; //load input data as LSB and shift (left) all other bits 
            end	
end

always @(posedge clk) begin
    if(bit_counter == 3'd7) begin  
    flag <= 1'b1;
    bit_counter <= 3'd0;
    end else begin 
    flag <= 1'b0;
    bit_counter <= bit_counter + 1'd1;
    end
end

	
	

	
	
	
localparam addrea_length = 16;	
localparam wr_rd_bit_length = 8;

	reg[15:0] addr_reg = 0;

	
	
always @(flag == 1'b1) 
begin : sh_case
    if (temp_reg == command_read) begin
                cr = 1; 
            end else if (temp_reg == command_write) 
	begin                 cw = 1;
           end else begin 
                {cr ,cw} =0;
            end
end

assign data_out = temp_reg[7];

endmodule
