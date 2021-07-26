// -----------------------------------------------------------------------------------------
// Version | Programmer                                     | Date       | Remark   
// -----------------------------------------------------------------------------------------
// V1      | Dr Kwen-Siong Chong (kschong@ntu.edu.sg)       | 31/07/2013 | Initial version
// -----------------------------------------------------------------------------------------  
//
// The code is a test benchmark for checking a full adder
// The code is for teaching purpose in the NTU-TUM class, NM6008.  

module FullAdder_tb;

parameter N = 8;
parameter DELAY = 50;

reg CIN;
reg A;
reg B;

wire S;
wire COUT;

//input vector
reg [2:0] REG_DATA [N-1: 0];

integer file1;
integer i;

FullAdder U1 (  //inputs
				.CIN (CIN),
				.A   (A),
				.B   (B),
				//outputs
				.S   (S),
				.COUT(COUT));

initial
	begin
		file1 = $fopen("./Check.txt");
		if (!file1) $finish;

		$readmemh("./InputVector.txt", REG_DATA);
	end

initial
	begin
		CIN = 0;
		A = 0;
		B = 0;

		$fdisplay(file1, "No/tB/tA/tCIN/tS/tCOUT");

		for (i = 0; i < N; i = i + 1)
			begin
				{B, A, CIN} = REG_DATA[i];

				$fdisplay(file1, "%d\t%d\t%d\t%d\t%d\t%d", i, CIN, A, B, S, COUT);
				#(DELAY);
			end

		$fclose(file1);
		$finish;
	end

initial
	begin
		#(100*DELAY);
		$finish;
	end

endmodule
