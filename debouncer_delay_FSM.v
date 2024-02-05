`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hamza Ali 
// 
// Create Date: 08/21/2023 03:25:33 PM
// Design Name: 
// Module Name: debouncer_delay_FSM
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


module debouncer_delay_FSM(
    input clk,
    input reset,
    input noisy,
    input timer_done,
    output timer_reset,
    output debounced
    );
    
    reg state_reg , state_next;
    parameter s0 = 0 , s1 = 1 , s2 = 2 , s3 = 3;
    
    //sequensial state register
    always@(posedge clk  , negedge reset)
    begin
    
        if(~reset)
            state_reg <= s0;
        else
            state_reg <= state_next;
    
    end
    
    //next state logic 
    always@(*)
    begin
        state_next = state_reg;
        
              case(state_reg)
                    s0 : if(~noisy)
                          state_next = s0;
                          else
                          state_next = s1;
                    s1 : if(~noisy)
                          state_next = s0;
                         else if(noisy & ~timer_done)
                          state_next = s1;
                         else if(noisy & timer_done)
                          state_next = s2;
                    s2 : if(~noisy)
                         state_next = s3;
                         else
                         state_next = s2;    
                    s3 : if(~noisy)
                        state_next = s0;
                        else if(~noisy & ~timer_done)
                        state_next = s3;
                        else if(~noisy & timer_done)
                        state_next = s0; 
                default state_next = s0;
            endcase
    end
    
    //output
    
    assign timer_reset = (state_reg == s0) | (state_reg == s2);
    assign debounced = (state_reg == s2) | (state_reg == s3);
    
    
endmodule
