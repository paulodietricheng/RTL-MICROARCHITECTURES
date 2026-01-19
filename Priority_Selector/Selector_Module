`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/08/2026 12:59:00 PM
// Design Name: Selector Module
// Module Name: Selector_Module
// Project Name: Priority Selector
// Revision 0
//////////////////////////////////////////////////////////////////////////////////


module Selector_Module #(
    parameter int DATA_W = 16,
    parameter int IDX_W  = 3
    )(
        input  logic valid_a, valid_b,
        input  logic [DATA_W-1:0] data_a, data_b,
        input  logic [IDX_W-1:0]  idx_a, idx_b,
    
        output logic valid_w,
        output logic [IDX_W-1:0]  idx_w,
        output logic [DATA_W-1:0] data_w
    );

    // Search for Valid
    always_comb begin
        if (valid_a) begin
            idx_w   = idx_a;
            data_w  = data_a;
            valid_w = 1;
        end
        else if (valid_b) begin
            idx_w   = idx_b;
            data_w  = data_b;
            valid_w = 1;
        end
        else begin
            idx_w   = '0;
            data_w  = '0;
            valid_w = 0;
        end
    end

endmodule
