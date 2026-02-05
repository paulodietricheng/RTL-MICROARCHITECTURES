`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 02/05/2026 11:38:15 AM
// Module Name: Module_Arbiter
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////



module PIP_Timestamped_Arbiter #(
    parameter int DATA_W = 16,
    parameter int TIMESTAMP_W = 16,
    parameter int N = 8
    )(
        //Signals
        input logic clk, rst_n,
        
        //inputs
        input logic [DATA_W-1:0] data [0:N-1],
        input logic valid [0:N-1],
        input logic [TIMESTAMP_W-1:0] timestamp [0:N-1],
        
        //outputs
        output logic [DATA_W-1:0] data_w,
        output logic valid_w,
        output logic [TIMESTAMP_W-1:0] timestamp_w
    );
    
    //parameters
    localparam STAGES = $clog2(N);
    
    //Stage arrays
    logic [0:STAGES][0:N-1][DATA_W-1:0] d;
    logic [0:STAGES][0:N-1]v;
    logic [0:STAGES][0:N-1][TIMESTAMP_W-1:0] t;
    
    //Populate array
    always_ff @(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            d[0] = '0;
            v[0] = '0;
            t[0] = '0;
        end else begin
            for (int k = 0; k < N; k++) begin
                d[0][k] = data[k];
                v[0][k] = valid[k];
                t[0][k] = timestamp[k]; 
            end
        end
    end
    
    //Tree generation
    genvar s, k;
    generate
        for (s = 0; s < STAGES; s++) begin : GEN_TREE
            for (k = 0; k < (N >> s); k += 2) begin : GEN_NODE
            
            logic [DATA_W-1:0]d_w;
            logic v_w;
            logic [TIMESTAMP_W-1:0] t_w;
            
                //Instantiate arbiter
                Module_Arbiter #(
                    .DATA_W(DATA_W),
                    .TIMESTAMP_W(TIMESTAMP_W)
                ) U_ARB ( 
                    .data_a(d[s][k]),
                    .data_b(d[s][k+1]),
                    .valid_a(v[s][k]),
                    .valid_b(v[s][k+1]),
                    .timestamp_a(t[s][k]),
                    .timestamp_b(t[s][k+1]),
                    .data_w(d_w),
                    .valid_w(v_w),
                    .timestamp_w(t_w)
                );
               
                //Stage pipeline
                always_ff @(posedge clk, negedge rst_n) begin
                    if(!rst_n) begin
                        d[s+1][k>>1] = '0;
                        v[s+1][k>>1] = '0;
                        t[s+1][k>>1] = '0;
                    end else begin
                        d[s+1][k>>1] = d_w;
                        v[s+1][k>>1] = v_w;
                        t[s+1][k>>1] = t_w;  
                    end
                end                
            end
        end
    endgenerate
    
    //output register
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            data_w <= '0;
            valid_w <= '0;
            timestamp_w <= '0;
        end
        else begin
            data_w <= d[STAGES][0];
            valid_w <= v[STAGES][0];
            timestamp_w <= t[STAGES][0];
        end
    end
                    
endmodule
