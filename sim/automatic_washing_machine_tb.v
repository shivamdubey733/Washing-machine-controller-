`timescale 10ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Design Name: Automatic Washing Machine Controller Testbench
// Module Name: automatic_washing_machine_tb
// Target Devices: Simulation (ModelSim, Icarus Verilog, Vivado Simulator)
//////////////////////////////////////////////////////////////////////////////////

module automatic_washing_machine_tb();

	// Testbench stimulus registers
	reg clk;
	reg reset;
	reg door_close;
	reg start;
	reg filled;
	reg detergent_added;
	reg cycle_timeout;
	reg drained;
	reg spin_timeout;

	// Output monitoring wires
	wire door_lock;
	wire motor_on;
	wire fill_value_on;
	wire drain_value_on;
	wire done;
	wire soap_wash;
	wire water_wash; 
	
	// Instantiate the Unit Under Test (UUT)
	automatic_washing_machine uut (
		.clk(clk), 
		.reset(reset), 
		.door_close(door_close), 
		.start(start), 
		.filled(filled), 
		.detergent_added(detergent_added), 
		.cycle_timeout(cycle_timeout), 
		.drained(drained), 
		.spin_timeout(spin_timeout), 
		.door_lock(door_lock), 
		.motor_on(motor_on), 
		.fill_value_on(fill_value_on), 
		.drain_value_on(drain_value_on), 
		.done(done), 
		.soap_wash(soap_wash), 
		.water_wash(water_wash)
	);

	// Clock Generation (100 MHz clock period = 10ns)
	always
	begin
		#5 clk = ~clk;
	end

	// Stimulus sequence
	initial
	begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		start = 0;
		door_close = 0;
		filled = 0;
		drained = 0;
		detergent_added = 0;
		cycle_timeout = 0;
		spin_timeout = 0;
		
		// Apply Reset
		#10 reset = 0;
		
		// User starts machine and closes door
		#10 start = 1; door_close = 1;
		
		// Water fills to required level
		#10 filled = 1;
		
		// Detergent added
		#10 detergent_added = 1;
		
		// Wash cycle agitation completes
		#10 cycle_timeout = 1;
		
		// Dirty wash water drained
		#10 drained = 1;
		
		// Spin dry cycle completes
		#10 spin_timeout = 1;
		
		#50;
		$display("Simulation Finished Successfully!");
		$finish;
	end
	
	// Real-time Console Monitor
	initial
	begin
		$monitor("Time=%0t | State: door_lock=%b, motor_on=%b, fill_valve=%b, drain_valve=%b, soap_wash=%b, water_wash=%b, done=%b",
			$time, door_lock, motor_on, fill_value_on, drain_value_on, soap_wash, water_wash, done);
	end
      
endmodule
