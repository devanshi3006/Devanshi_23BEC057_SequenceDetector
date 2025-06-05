`timescale 1ns/1ns
`include "seq_det.v" // includes the module definition for the sequence detector
module testbench;
	reg data_in;
	reg Clock, reset;
	wire detected;

// Instantiate the module under test
seq_det dut (.data_in(data_in), .Clock(Clock), .reset(reset), .detected(detected));

// Clock generation
always #5 Clock = ~Clock; // Clock signal with a period of 10 ns

// Stimulus
initial begin
	 $fsdbDumpvars();

//Tool specific command. Creates novas.fsdb file. Used for waveform generation
//// Reset inputs
//
	data_in <= 0; Clock <= 0; reset <= 1;
	
	// Release reset
	#20 reset <= 0;
	
// Apply test cases
	// Test sequence: 1101101110110
	#10 data_in <= 1; // 1
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 11
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 0; // 110 - Should detect here
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 1101
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 11011
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 0; // 110110 - Should detect here
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 1101101
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 11011011
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 110110111
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 0; // 1101101110 - Should detect here
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 11011011101
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 1; // 110110111011
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);
	
	#10 data_in <= 0; // 1101101110110 - Should detect here
	$display("Time: %0t, data_in = %b, detected = %b", $time, data_in, detected);

	#100 $finish;

	end
endmodule
