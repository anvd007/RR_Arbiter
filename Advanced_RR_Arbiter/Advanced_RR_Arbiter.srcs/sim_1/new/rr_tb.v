`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2024 18:38:28
// Design Name: 
// Module Name: rr_tb
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

module rr_tb();
        reg clk;
        reg reset;
        reg [3:0] request;
        reg [3:0] mask;
        // Outputs
        wire [3:0] grant;
    
        // Instantiate the Arbiter module
        A_RR_Arbiter uut (
            .clk(clk),
            .reset(reset),
            .request(request),
            .mask(mask),
            .grant(grant)
        );
    
        // Clock generation
        always #5 clk = ~clk;  // 10-time unit clock period
    
        initial begin
            // Initialize inputs
            clk = 0;
            reset = 1;
            request = 4'b0000;
            mask = 4'b1000;
            // Time Quantum is the Time Period = 10 ns
       
            // Apply reset
            #10 reset = 0;
            // Test Case 1: Request from Master 0
            #10 request = 4'b0001;
            #10 request = 4'b0011; 
//            #10 request = 4'b0000;
            #10 request = 4'b0101;
            #10 request = 4'b0110;
//            #10 request = 4'b0000;
            #50 $finish;
        end
endmodule
