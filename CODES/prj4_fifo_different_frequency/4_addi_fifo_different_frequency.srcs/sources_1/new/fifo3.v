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
    input output_enable //input_valid��output_enable���ⲿ�Ŀ����ź�
    );
    
    
    reg [15:0] mem [31:0];//��ʾÿ�����ݵĳ���Ϊ16,һ����32������
    reg [5:0] write_addr;//��ʾд��ʱ��ĵ�ַ, ��Ϊһ����32��,������������Ҫ��5λ����ʾ���ݵ�ַ
    reg [5:0] read_addr;
    
    reg write;//���ڱ�ʾ��ǰfifo��״̬��д�뻹�Ƕ���
    reg read;
    reg input_enable;
    reg output_valid;
    reg [3:0]write_period;
    reg [3:0]read_period;
    
    reg read_state;//��Ϊ��8λ8λд��, ����������һ����������ʾд���ڵ�8λ���Ǹ�8λ
    
    
    always @(negedge rstn or posedge clk)begin
        if(rstn==0)begin
            write_addr <= 5'b000000;//��ʼ������Ͷ���,�����֤�������ȳ�
            read_addr <= 5'b000000;
            input_enable <= 1;//��ʾһ��ʼ�����Զ���, ����
            output_valid <= 1;
            read_state <= 0;
            read_period <= 0;
            write_period <= 0;
        end
        else begin
        if(write == 1)begin//������д��״̬
            mem[write_addr][15:0] <= data_in[15:0];//ÿ��д��16λ����
                 if(write_addr < 31)begin//�����ǰ32�����, ��������
                     write_addr <= write_addr+1;
                 end
                 else   begin
                 write_addr <= 0;
                 write_period = write_period + 1;    //����Ѿ�д����,�Ͳ��ܼ���д��    
                 end
            end
        end
        if(read == 1)begin//write��read������if-else������, �������﷨�¶���Ӧ�ÿ���ͬʱ����
            if(read_addr < write_addr || read_period < write_period) begin//�����жϽ�����Ҫ�����ĵ�ַ�ǲ���û��д������
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
            else begin//���Ҫ�������ǿյ�, �Ͳ�����
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
