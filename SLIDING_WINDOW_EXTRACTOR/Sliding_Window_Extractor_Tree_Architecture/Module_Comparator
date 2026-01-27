`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paulo Dietrich
// Create Date: 01/23/2026 11:57:02 AM  
// Module Name: Module_Comparator
// Project Name: Sliding_Window_Extractor_Tree_based
// Revision: 0
//////////////////////////////////////////////////////////////////////////////////

module Module_Comparator #(
    parameter DATA_W = 64
    )(
        //input
        input logic [DATA_W-1:0] data_0, data_1,
        
        //output
        output logic [DATA_W-1:0] data_w
    );
    
    //Compare the magnitudes
    always_comb begin
        if (data_0 > data_1)
            data_w = data_0;
        else
            data_w = data_1;
    end
endmodule
