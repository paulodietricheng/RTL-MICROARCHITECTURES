`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/22/2026 03:43:57 PM
// Module Name: Sliding_Window_Extractor
// Project Name: Sliding_Window_Extractor_MUX_Chain
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////

module MUX_Chain_Architecture#(
        parameter WINDOW_SIZE = 128,
        parameter DATA_W = 64
    )(
        //Signals
        input logic clk, rst_n,
    
        //Input
        input logic [DATA_W-1:0] data [0:WINDOW_SIZE-1],
        
        //Output
        output logic [DATA_W-1:0] data_w
    );
        
    logic [DATA_W-1:0] data_w_atm; //Comparator variable
    logic [DATA_W-1:0] data_w_reg; //Register variable
    
    //Compare the magnitudes
    always_comb 
        begin
        data_w_atm = data[0];
        for(int i = 1; i < WINDOW_SIZE; i++) begin
            if(data[i] > data_w_atm)
                data_w_atm = data[i];
        end    
    end
    
    //Output register
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n)
            data_w_reg <= '0;
        else
            data_w_reg <= data_w_atm;
    end
    
    assign data_w = data_w_reg;
endmodule
