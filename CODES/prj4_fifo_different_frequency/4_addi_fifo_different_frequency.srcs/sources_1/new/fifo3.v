`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 22:32:04
// Design Name: 
// Module Name: fifo3
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


module fifo3(
    input clk,
    input rstn,
    
    input [15:0] data_in,
    input input_valid,
    
    output reg [7:0] data_out,
    input output_enable //input_valid和output_enable是外部的控制信号
    );
    
    
    reg [15:0] mem [31:0];//表示每组数据的长度为16,一共有32组数据
    reg [5:0] write_addr;//表示写入时候的地址, 因为一共有32组,所以在这里需要用5位来表示数据地址
    reg [5:0] read_addr;
    
    reg write;//用于表示当前fifo的状态是写入还是读出
    reg read;
    reg input_enable;
    reg output_valid;
    reg [3:0]write_period;
    reg [3:0]read_period;
    
    reg read_state;//因为是8位8位写入, 所以用这样一个数据来表示写入在低8位还是高8位
    
    
    always @(negedge rstn or posedge clk)begin
        if(rstn==0)begin
            write_addr <= 5'b000000;//初始化读入和读出,这个保证了先入先出
            read_addr <= 5'b000000;
            input_enable <= 1;//表示一开始都可以读入, 读出
            output_valid <= 1;
            read_state <= 0;
            read_period <= 0;
            write_period <= 0;
        end
        else begin
        if(write == 1)begin//读到是写入状态
            mem[write_addr][15:0] <= data_in[15:0];//每次写入16位数据
                 if(write_addr < 31)begin//如果是前32个广度, 继续读入
                     write_addr <= write_addr+1;
                 end
                 else   begin
                 write_addr <= 0;
                 write_period = write_period + 1;    //如果已经写满了,就不能继续写了    
                 end
            end
        end
        if(read == 1)begin//write和read并不是if-else的两端, 在这种语法下二者应该可以同时进行
            if(read_addr < write_addr || read_period < write_period) begin//用于判断接下来要读出的地址是不是没有写入数据
                if(read_state == 0) begin
                    read_state <= ~read_state;
                    data_out[7:0] <= mem[read_addr][7:0];
                end
                else begin
                    read_state <= ~read_state;
                    data_out[7:0] <= mem[read_addr][15:8];
                    if(read_addr < 31)begin
                        read_addr <= read_addr+1;
                    end
                    else begin
                    read_addr <= 0;
                    read_period = read_period+1;
                    end
                end
            end
            else begin//如果要读出的是空的, 就不读出
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
