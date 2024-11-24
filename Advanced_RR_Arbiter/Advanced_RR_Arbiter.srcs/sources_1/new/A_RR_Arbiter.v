`timescale 1ns / 1ps

module A_RR_Arbiter(
    input clk,                      // System clock
    input reset,                    // Active high reset
    input [3:0] request,            // 4-bit request signals from 4 masters
    input [3:0] mask,               // 4-bit mask to selectively ignore requests :: If high the request are masked for consideration
    output reg [3:0] grant          // 4-bit grant signals to the 4 masters
);
    reg [1:0] current_priority;     // Track the current master in priority
    reg [3:0] turn_counter;         // Counts turns based on weight
    reg [3:0] weights [3:0];        // Weights for each master ( Weights = Threshold limit for the grant to each master )
    
    initial begin
    current_priority <= 2'b00;
    turn_counter <= 4'd0;
    grant <= 4'b0000;
    weights[0] = 4'd1;    
    weights[1] = 4'd2;
    weights[2] = 4'd4;
    weights[3] = 4'd6;
    end
    
    // Procedural Code, clocked sequential logic for the Advanced Round Robbin
    always @(posedge clk or posedge reset)  begin
    if(reset) begin 
    current_priority <= 2'b00;
    turn_counter <= 4'd0;
    end
    
    else begin
    case(current_priority)
    2'b00 : begin
    end
    endcase
    end
    end
    
    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    // Initialize weights for each master
    initial begin
        weights[0] = 4; // Master 0 has weight of 4
        weights[1] = 2; // Master 1 has weight of 2
        weights[2] = 3; // Master 2 has weight of 3
        weights[3] = 1; // Master 3 has weight of 1
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            grant <= 4'b0000;              // Reset grant
            current_priority <= 2'b00;     // Reset priority to master 0
            turn_counter <= 0;             // Reset turn counter
        end
        else begin
            grant <= 4'b0000;
            // Check if current master’s request is not masked and turn count is within weight
            if ((mask[current_priority] == 1'b0) && request[current_priority] && 
                (turn_counter < weights[current_priority])) begin
                // Grant access to the current master
                grant <= 4'b0001 << current_priority;
                turn_counter <= turn_counter + 1;
            end
            else begin
                // Move to the next master in round-robin order and reset turn counter
                turn_counter <= 0; 
                current_priority <= current_priority + 1;
                if (current_priority == 2'b11) begin
                    weights[0] <= weights[3];
                    weights[1] <= weights[2];
                    weights[2] <= weights[1];
                    weights[3] <= weights[0];
                    current_priority <= 2'b00; // Wrap back to master 0 after master 3
                end
            end
        end
    end
endmodule

