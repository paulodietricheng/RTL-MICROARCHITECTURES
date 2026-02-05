`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/18/2026 01:02:07 PM
// Design Name: Priority Selecor
// Module Name: Priority_Selector_tb
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////


module Priority_Selector_tb;
    // Parameters
    parameter int N = 8;
    parameter int DATA_W = 16;
    parameter int IDX_W = $clog2(N);
    
    //Signals
    logic clk, rst_n;
    logic [N-1:0] valid_in;
    logic [N-1:0][DATA_W-1:0] data_in;
    
    logic valid_out;
    logic [DATA_W-1:0] data_out;
    logic [IDX_W-1:0] idx_out;
    
    //Instantiate UUT
    Parametrized_Priority_Selector 
    #(
        .N(N),
        .DATA_W(DATA_W)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .valid_in(valid_in),
        .data_in(data_in),
        .valid_out(valid_out),
        .data_out(data_out),
        .idx_out(idx_out)
    );
  
    //Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    //Reset
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end
    
    //Test
    initial begin
        valid_in = '0;
        data_in = '0;
        
        #25;
        
        repeat (10) begin
          @(posedge clk);
    
          // Randomize valid bits
          valid_in = $urandom_range(0, 2**N-1);
    
          // Randomize data for each input
          for (int i = 0; i < N; i++) begin
            data_in[i] = $urandom;
          end
    
          // Wait 1 cycle for combinational output
          @(posedge clk);
    
          // Display
          $display("time=%0t valid_in=%b idx_out=%0d data_out=%0h valid_out=%b",
                   $time, valid_in, idx_out, data_out, valid_out);
        end
    
        $finish;
      end      
endmodule
