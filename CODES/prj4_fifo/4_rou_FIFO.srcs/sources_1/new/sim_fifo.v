`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 14:34:56
// Design Name: 
// Module Name: sim_fifo
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


module sim_fifo(
    input clk,
    input rstn,
    
    input [7:0] data_in,
    input input_valid,
    
    output reg [15:0]data_out,
    input output_enable //input_valid��output_enable���ⲿ�Ŀ����ź�
    );
    
    
    reg [15:0] mem [31:0];//��ʾÿ�����ݵĳ���Ϊ16,һ����32������
    reg [6:0] write_addr;//��ʾд��ʱ��ĵ�ַ, ��Ϊһ����32��,������������Ҫ��5λ����ʾ���ݵ�ַ
    reg [6:0] read_addr;
    
    reg write;//���ڱ�ʾ��ǰfifo��״̬��д�뻹�Ƕ���
    reg read;
    reg input_enable;
    reg output_valid;
    
    reg write_state;//��Ϊ��8λ8λд��, ����������һ����������ʾд���ڵ�8λ���Ǹ�8λ
    
    
    always @(negedge rstn or posedge clk)begin
        if(rstn==0)begin
            write_addr <= 6'b000000;//��ʼ������Ͷ���,�����֤�������ȳ�
            read_addr <= 6'b000000;
            input_enable <= 1;//��ʾһ��ʼ�ǴӶ��뿪ʼ��
            output_valid <= 0;//��ʾһ��ʼ������, ֻд��
        end
        else begin
        if(write == 1)begin//д���8λ
            if(write_state==0)begin
                write_state <= ~write_state;
                mem[write_addr][7:0] <= data_in[7:0];
            end
            else begin//д���8λ
                write_addr <= write_addr+1;
                write_state <= ~write_state;
                mem[write_addr][15:8] <= data_in[7:0];
            end
            if(write_addr == 32)begin//д��,��ʼ����
                input_enable = 0;
                output_valid = 1;
                write_addr <= 6'b000000;
            end
        else if(read == 1)begin
                read_addr <= read_addr+1;
            data_out[15:0] <= mem[read_addr][15:0];
            end
            
         end
     end
     
     always @(*)begin
        write = input_valid && input_enable;
     end
     
     always @(*)begin
        read = output_valid && output_enable;
     end
    
    always @(*) begin 
         if(write_addr == 31)begin//���write_addr=32,˵��mem�Ѿ���д��,Ҫ��ʼ����
            input_enable = 0;
            output_valid = 1;
            write_addr <= 6'b000000;
          end
     end
     
     always @(*) begin 
        if(read_addr == 31)begin//���write_addr=32, ˵��mem�Ѿ�������, ��Ҫ��ʼд��
            input_enable = 1;
            output_valid = 0;
            read_addr <= 6'b000000;
         end
      end
    
endmodule
