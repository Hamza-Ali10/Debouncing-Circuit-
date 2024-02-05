`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hamza ALi
// 
// Create Date: 08/21/2023 03:45:24 PM
// Design Name: 
// Module Name: debouncer_delay
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


module debouncer_delay(
    input clk,
    input reset,noisy,
    output debounced
    );
    
    wire timer_done , timer_reset;
    
    debouncer_delay_FSM FSM0(
        .clk(clk),
        .reset(reset),
        .noisy(noisy),
        .timer_done(timer_done),
        .timer_reset(timer_reset),
        .debounced(debounced)
        );
    
    Timing_parameter #(.final_value(1_999_999)) T0(
    .clk(clk),
    .reset(~timer_reset),
    .enable(~timer_reset),
    .done(timer_done)
    
    );
endmodule
