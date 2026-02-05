`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/21/2026 08:11:11 AM
// Design Name: Valid Ready Handshake
// Module Name: Valid_Ready_Module
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////


module Valid_Ready_Module #(
    parameter DATA_W = 32
    )(
        //signals
        input logic clk, rst_n,
    
        // upstream
        input logic              valid_in,
        input logic [DATA_W-1:0] data_in,
        output logic              ready_out,
    
        // downstream
        output logic              valid_out,
        output logic [DATA_W-1:0] data_out,
        input  logic              downstream_ready
    );
    
    //create register variables    
    logic [DATA_W-1:0] data_reg;
    logic valid_reg; //has meaningful data

    // ready when empty or when downstream is ready to process the data
    assign ready_out = ~valid_reg || downstream_ready;

    /*If there is meaningful data from upstream (valid_in == 1) and if the flag ready_out is
    set to true, then register data_in and set valid_reg to 1*/

    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            valid_reg <= 1'b0;
        end else if (ready_out) begin
            // capture new data if available
            valid_reg <= valid_in;
            if (valid_in)
                data_reg <= data_in;
        end
    end

    assign data_out  = data_reg;
    assign valid_out = valid_reg;

endmodule
