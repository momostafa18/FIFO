
module FIFO_Testbench;

  // Parameters
  parameter DBits = 8;
  
  // DUT Ports
  reg [DBits-1:0] Input_Data_bits;
  reg clk;
  reg areset;
  reg Read_Enable;
  reg Write_Enable;
  wire [DBits-1:0] Output_Data_bits;
  wire Empty;
  wire Full;

  // Instantiate FIFO module
  FIFO #(.DBits(DBits)) dut (
    .Input_Data_bits(Input_Data_bits),
    .clk(clk),
    .areset(areset),
    .Read_Enable(Read_Enable),
    .Write_Enable(Write_Enable),
    .Output_Data_bits(Output_Data_bits),
    .Empty(Empty),
    .Full(Full)
  );
  
  // Clock generation
  always begin
    #50 clk = ~clk;
  end
  
  // Reset initialization
  initial begin
    areset = 0;
    #100 areset = 1;
  end
  
  // Test cases
  initial begin
    // Case 1: Empty FIFO, read should have no effect
    Read_Enable = 1;
    #100;
    Read_Enable = 0;
    
    // Case 2: Write data to the FIFO and read it back
    Write_Enable = 1;
    Input_Data_bits = 8'hFF; // Example data
    #100;
    Write_Enable = 0;
    #100;
    Read_Enable = 1;
    #100;
    Read_Enable = 0;
    
    // Case 3: Full FIFO, write should have no effect
	repeat (15000)
	begin
	Input_Data_bits = 8'b10100001;
    Write_Enable = 1;
	end
	#100 
    Input_Data_bits = 8'b10101101;
	#20000
	Read_Enable = 1;
    Write_Enable = 0;	
    #3000;
   
	Read_Enable = 0;

    
    // Add more test cases as needed
    
    // End simulation
    #100;
    $finish;
  end
  
endmodule
