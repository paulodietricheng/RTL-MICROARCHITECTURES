`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/21/2026 09:41:01 AM
// Design Name: Valid-Ready Module
// Module Name: Valid_Ready_Module_tb
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////


module Valid_Ready_Module_tb;

    parameter DATA_W = 8;

    //signals
    logic clk;
    logic rst_n;
    
    //upstream
    logic valid_in;
    logic [DATA_W-1:0] data_in;
    logic ready_out;
    
    //downstream
    logic downstream_ready;
    logic [DATA_W-1:0] data_out;
    logic valid_out;

    // Instantiate the DUT
    Valid_Ready_Module #(.DATA_W(DATA_W)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .valid_in(valid_in),
        .data_in(data_in),
        .ready_out(ready_out),
        .downstream_ready(downstream_ready),
        .data_out(data_out),
        .valid_out(valid_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10 ns period

    // Reset sequence
    initial begin
        rst_n = 1;
        #12;
        rst_n = 0;
        #12;
        rst_n = 1;
    end

    // Stimulus: valid_in and data_in
    initial begin
        valid_in = 0;
        data_in  = 0;
        @(posedge rst_n);

        // First data
        @(posedge clk);
        valid_in = 1;
        data_in  = 8'hAA;

        @(posedge clk);
        data_in  = 8'hBB;

        @(posedge clk);
        valid_in = 0;

        @(posedge clk);
        valid_in = 1;
        data_in  = 8'hCC;

        @(posedge clk);
        valid_in = 1;
        data_in  = 8'hDD;

        @(posedge clk);
        valid_in = 0;
    end

    // Simulate downstream_ready behavior
    initial begin
        downstream_ready = 1;

        // Stall downstream for a few cycles
        #20;
        downstream_ready = 0;

        #20;
        downstream_ready = 1;
    end

    // Monitor outputs
    always @(posedge clk) begin
        $display("t=%0t | valid_in=%b | data_in=%h | downstream_ready=%b | data_out=%h | ready_out=%b | valid_out=%b",
                  $time, valid_in, data_in, downstream_ready, data_out, ready_out, valid_out);
    end

    // Stop simulation
    initial begin
        #50
        $finish;
    end

endmodule
