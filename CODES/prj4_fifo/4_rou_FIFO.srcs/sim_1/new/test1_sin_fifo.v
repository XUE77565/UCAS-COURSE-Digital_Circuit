`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 16:36:16
// Design Name: 
// Module Name: test1_sim_fifo
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


module test1_sim_fifo(

    );
    reg clk;
    reg rstn;
    reg [7:0] data_in;
    reg input_valid;
    reg output_enable;
    wire [15:0] data_out;

    // Instantiate the sim_fifo module
    sim_fifo uut (
        .clk(clk),
        .rstn(rstn),
        .data_in(data_in),
        .input_valid(input_valid),
        .data_out(data_out),
        .output_enable(output_enable)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        rstn = 0;
        #10 rstn = 1;
    end

    // Random control for input_valid and output_enable
    always @(posedge clk) begin
        input_valid = $random % 2;
        output_enable = $random % 2;
    end

    // Stimulus
    initial begin
        data_in = 8'h00;
        
        // Apply some data
        #20;
        repeat (64) begin
            @(posedge clk);
            if (input_valid && uut.input_enable) begin
                data_in = data_in + 1;
            end
        end

        // Wait for some time
        #100;
        
        // Finish the simulation
        $stop;
    end
endmodule