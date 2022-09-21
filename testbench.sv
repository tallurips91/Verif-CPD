module tb;
  
   logic [3:0] gray_in_tb;
   logic clk_tb;
   logic rst_tb; //active high
   reg [3:0] bin_out_tb;
   event check_result_event;
  
  gray2bin dut(
    .gray_in(gray_in_tb),
    .clk(clk_tb),
    .rst(rst_tb),
    .bin_out(bin_out_tb)
  );
  
  //Waveform generation
  initial begin
  	$dumpfile("dump.vcd");
  	$dumpvars;
  	#300 
  	$finish;
	end
  
  //Clock generation
  always 
    #5 clk_tb =  ~clk_tb;
  
  /*
  initial begin
    $monitor("T=%3d,gray_in_tb=%d,bin_out_tb=%d,rst_tb=%d",$time,gray_in_tb,bin_out_tb,rst_tb);
  end
  */
  
  function logic [3:0] binary_expected (input logic [3:0] gray_value);
    binary_expected[3] = gray_value[3];
    binary_expected[2] = gray_value[3] ^ gray_value[2];
    binary_expected[1] = gray_value[3] ^ gray_value[2] ^ gray_value[1];
    binary_expected[0] = gray_value[3] ^ gray_value[2] ^ gray_value[1] ^ gray_value[0];
  endfunction
  
  task check_result(input [3:0] gray_in_tb);
       
    logic [3:0] expected_value;
    
    //@(posedge clk_tb);
    
    expected_value = binary_expected(gray_in_tb);
    
    #2;	//Reading bin_out_tb after the edge transistion
    
    if (bin_out_tb != expected_value)
    	$error("Time = %3d, Expected binary value is %d, actual value is %d for the gray input = %d",$time,expected_value, bin_out_tb,gray_in_tb);
  	endtask
  
  always @(check_result_event) check_result(gray_in_tb);
  
  initial begin
    
    clk_tb = 1'b1;
    rst_tb = 1'b1;
    repeat(2) @(posedge clk_tb);	//Delay by x clks
    rst_tb = 1'b0;
    @(posedge clk_tb) ;				//Deassert Reset
    
    //Generation
    for (int i=0;i<16;i=i+1) begin
      @(negedge clk_tb) gray_in_tb = i;
  	end
  end
  
  //Checking
  always  @(posedge clk_tb) begin
   // #2;
     -> check_result_event;
  end
  
endmodule
