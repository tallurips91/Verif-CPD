`timescale 1ns / 1ps
module gray2bin (
  input logic [3:0] gray_in,
  input logic clk,
  input logic rst, //active high
  output logic [3:0] bin_out); 
  
  always@(posedge clk) 
    begin
      if (rst)
        bin_out[3:0] <= 4'b0000;
      else
        begin
          bin_out[3] <= gray_in[3];
          bin_out[2] <= gray_in[3] ^ gray_in[2];
          bin_out[1] <= gray_in[3] ^ gray_in[2] ^ gray_in[1];
          bin_out[0] <= gray_in[3] ^ gray_in[2] ^ gray_in[1] ^ gray_in[0]; 
        end
    end
  
endmodule
