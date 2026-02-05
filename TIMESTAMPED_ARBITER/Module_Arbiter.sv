`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 02/05/2026 11:48:17 AM
// Module Name: Module_Arbiter
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////

module Module_Arbiter #(
    parameter int DATA_W = 16,
    parameter int TIMESTAMP_W = 16
    )(
        //inputs
        input logic [DATA_W-1:0] data_a, data_b,
        input logic valid_a, valid_b,
        input logic [TIMESTAMP_W-1:0] timestamp_a, timestamp_b,
        
        //outputs
        output logic [DATA_W-1:0] data_w,
        output logic valid_w,
        output logic [TIMESTAMP_W-1:0] timestamp_w
    );
    
    always_comb begin
        if (valid_a && valid_b) begin
            if (timestamp_a <= timestamp_b) begin
                valid_w = valid_a;
                timestamp_w = timestamp_a;
                data_w = data_a;
            end                
            else begin
                valid_w = valid_b;
                timestamp_w = timestamp_b;
                data_w = data_b;
            end
        end
        else if (valid_a && !valid_b) begin
            valid_w = valid_a;
            timestamp_w = timestamp_a;
            data_w = data_a;    
            end
        else if (!valid_a && valid_b) begin
            valid_w = valid_b;
            timestamp_w = timestamp_b;
            data_w = data_b;
        end
        else
            valid_w = 1'b0;
    end
endmodule
