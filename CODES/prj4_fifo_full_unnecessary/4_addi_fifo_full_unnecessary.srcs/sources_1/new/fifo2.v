`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 22:00:03
// Design Name: 
// Module Name: fifo2
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


module fifo2(
    input clk,
    input rstn,
    
    input [7:0] data_in,
    input input_valid,
    
    output reg [15:0] data_out,
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
    reg [3:0]write_period;
    reg [3:0]read_period;
    
    
    always @(negedge rstn or posedge clk)begin
        if(rstn==0)begin
            write_addr <= 6'b000000;//��ʼ������Ͷ���,�����֤�������ȳ�
            read_addr <= 6'b000000;
            input_enable <= 1;//��ʾһ��ʼ�����Զ���, ����
            output_valid <= 1;
            write_state <= 0;
            write_period <= 0;
            read_period <=0;
        end
        else begin
        if(write == 1)begin//������д��״̬
             if(write_state == 0)begin
                 write_state <= ~write_state;
                 mem[write_addr][7:0] <= data_in[7:0];
             end
             else  begin
                 write_state <= ~write_state;
                 mem[write_addr][15:8] <= data_in[7:0];
                 if(write_addr < 31)begin//�����ǰ32�����, ��������
                     write_addr <= write_addr+1;
                 end
                 else   begin
                 write_addr <= 0;   //�����д��, ��ͷ��д
                 write_period = write_period +1;//��ʾд����һȦ
                 end
            end
        end
        if(read == 1)begin//write��read������if-else������, �������﷨�¶���Ӧ�ÿ���ͬʱ����
            if((read_addr < write_addr) || (read_period < write_period)) begin//�����жϽ�����Ҫ�����ĵ�ַ�ǲ���û��д������
                data_out[15:0] = mem[read_addr][15:0];
                if(read_addr < 31) begin //����ǲ��Ƕ���
                    read_addr <= read_addr+1;
                end
                else begin
                    read_addr <= 0;//��ʾ������һ������
                    read_period = read_period+1;//�������ڼ�1
                end
            end
            else begin//���Ҫ�������ǿյ�, �Ͳ�����
            end
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