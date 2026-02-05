`timescale 1ns / 1ps
// Engineer: Paulo Dietrich
// Create Date: 01/29/2026 10:30:52 AM
// Module Name: Sliding_Window_Monotonic_Deque
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////
module sliding_window_max_monotonic #(
    parameter int DATA_W = 64,
    parameter int WINDOW_SIZE = 128   
    )(
        input logic clk, rst_n,
    
        input logic valid_in,
        input logic [DATA_W-1:0] data_in,
    
        output logic valid_out,
        output logic [DATA_W-1:0] data_max
    );

    // Derived parameters
    localparam int IDX_W = $clog2(WINDOW_SIZE);

    // Deque Variables
    logic [DATA_W-1:0] dq_data [WINDOW_SIZE];
    logic [IDX_W-1:0] dq_time [WINDOW_SIZE];
    logic [IDX_W-1:0] head, tail;
    logic [IDX_W:0] count;

    // Global timestamp
    logic [IDX_W-1:0]  timestamp;

    // Timestamp counter
    always_ff @(posedge clk) begin
        if (!rst_n)
            timestamp <= '0;
        else if (valid_in)
            timestamp <= timestamp + 1'b1;
    end


    // Front expiration check
    logic expire_front;
    assign expire_front = (count != 0) && ((timestamp - dq_time[head]) >= WINDOW_SIZE[IDX_W-1:0]);

    // Pop-back check
    logic pop_back;
    assign pop_back = valid_in && (count != 0) && (data_in >= dq_data[(tail - 1'b1) & (WINDOW_SIZE-1)]);

    // Main control
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            head <= '0;
            tail <= '0;
            count <= '0;
        end else begin

            // Expire old elements (front)
            if (expire_front) begin
                head  <= head + 1'b1;
                count <= count - 1'b1;
            end

            // Pop back
            else if (pop_back) begin
                tail  <= tail - 1'b1;
                count <= count - 1'b1;
            end

            // Push new element
            else if (valid_in) begin
                dq_data[tail] <= data_in;
                dq_time[tail] <= timestamp;
                tail <= tail + 1'b1;
                if (count != WINDOW_SIZE)
                    count <= count + 1'b1;
            end
        end
    end

    // Output
    assign valid_out = (count != 0);
    assign data_max  = valid_out ? dq_data[head] : '0;

endmodule
