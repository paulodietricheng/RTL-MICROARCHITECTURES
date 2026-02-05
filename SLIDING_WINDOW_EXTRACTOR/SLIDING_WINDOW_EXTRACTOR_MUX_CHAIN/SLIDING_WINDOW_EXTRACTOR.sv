`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/22/2026 03:56:56 PM
// Module Name: Sliding_Window_Extractor
// Project Name: Sliding_Window_Extractor_MUX_Chain
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////
module Sliding_Window_Extractor #(
    parameter int DATA_W = 64,
    parameter int WINDOW_SIZE = 128
    )(
        //Signals
        input logic clk, rst_n,
        
        //Input
        input logic [DATA_W-1:0] data,
        
        //Output
        output logic [DATA_W-1:0] data_w,
        output logic [DATA_W-1:0] data_out
    );
    
    //register arrays
    logic [DATA_W-1:0] data_reg [0: WINDOW_SIZE-1];
    
    //Instantiate comparator
    MUX_Chain_Architecture U1(
        .data(data_reg), 
        .data_w(data_w)
    );

    //Shift register
    always_ff@(posedge clk, negedge rst_n)
        begin
            if(!rst_n) begin
                for (int i = 0; i < WINDOW_SIZE; i++) begin
                    data_reg[i] <= '0;
                end
            end
            else begin
                data_reg[0] <= data;
                for (int i = 1; i < WINDOW_SIZE; i++) begin
                    data_reg[i] <= data_reg[i-1];
                end
            end
        end
        
        assign data_out = data_reg[WINDOW_SIZE - 1];
endmodule
