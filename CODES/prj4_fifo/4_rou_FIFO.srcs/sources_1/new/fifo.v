`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 21:44:46
// Design Name: 
// Module Name: fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo(
    input clk,
    input rstn,
    
    input [7:0] data_in,
    input input_valid,
    
    output reg [15:0] data_out,
    input output_enable //input_valid和output_enable是外部的控制信号
    );
    
    
    reg [15:0] mem [31:0];//表示每组数据的长度为16,一共有32组数据
    reg [6:0] write_addr;//表示写入时候的地址, 因为一共有32组,所以在这里需要用5位来表示数据地址
    reg [6:0] read_addr;
    
    reg write;//用于表示当前fifo的状态是写入还是读出
    reg read;
    reg input_enable;
    reg output_valid;
    
    reg write_state;//因为是8位8位写入, 所以用这样一个数据来表示写入在低8位还是高8位
    
    
    always @(negedge rstn or posedge clk)begin
        if(rstn==0)begin
            write_addr <= 6'b000000;//初始化读入和读出,这个保证了先入先出
            read_addr <= 6'b000000;
            input_enable <= 1;//表示一开始是从读入开始的
            output_valid <= 0;//表示一开始不读出, 只写入
            write_state <= 0;
        end
        else begin
        if(write == 1)begin//读到是写入状态
                if(write_state == 0)begin
                    write_state <= ~write_state;
                    mem[write_addr][7:0] <= data_in[7:0];
                end
                else begin
                    write_state <= ~write_state;
                    mem[write_addr][15:8] <= data_in[7:0];
                    if(write_addr < 31)begin//如果是前32个广度, 继续读入
                        write_addr <= write_addr+1;
                    end
                    else begin//发现地址超过31,说明写满了,转化为读出
                        input_enable <= 0;
                        output_valid <= 1;
                        write_addr <= 0;
                    end            
                end
        end
        else if(read == 1)begin
            data_out[15:0] <= mem[read_addr][15:0];
            if(read_addr < 31)begin
                read_addr <= read_addr+1;
            end
            else begin
                read_addr <= 0;
                input_enable <= 1;
                output_valid <= 0;
            end
        end
        else begin
        end
     end
 end
     
     always @(*) begin
        write = input_valid && input_enable;
     end
     
     always @(*) begin
        read = output_valid && output_enable;
     end
    
endmodule
