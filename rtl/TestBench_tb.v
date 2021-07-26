// -----------------------------------------------------------------------------------------
// Version | Programmer                                     | Date       | Remark   
// -----------------------------------------------------------------------------------------
// V1      | Dr Kwen-Siong Chong (kschong@ntu.edu.sg)       | 31/07/2013 | Initial version
// -----------------------------------------------------------------------------------------  
//
// The code is a test benchmark for checking a full adder
// The code is for teaching purpose in the NTU-TUM class, NM6008.  


// ************Add CLK: time format: set 1ns as system time unit, 1ps as time precision**************
`timescale 1ns/1ps 
// **************************************************************************************************

module TestBench_tb; // module's name should be the same as the file

parameter N = 8;
parameter DELAY = 50;

reg CIN, A, B;
wire S, COUT;
//Input Vector 
reg [2:0] REG_DATA [N-1:0];

integer file1,i ,j;
    
// *************************Add CLK: Backannotation***********************
initial $sdf_annotate("Syn_TestBench.sdf", U1);
// ***********************************************************************

// U1 is an object here
TestBench U1 ( // ports
		.CIN(CIN),
		.A(A),
		.B(B),
		.S(S),
		.COUT(COUT)
		);


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
// ****************Add CLK: enable the features of recording all the switching profile***************
    $vcdpluson(U1); 
// **************************************************************************************************
    $fdisplay(file1, "No\tB\tA\tCIN\tS\tCOUT");

    for (i = 0; i < N; i = i+1)
        begin
	        // Since (hexa) 7->1, 7->2, ..., 7->6 has already implemented while i = i + 1, 
            // only 7->0 needs to be set particularly.
            if(i == 7) // 1 switching pattern: 7->0
				begin
		    		{B, A, CIN} = REG_DATA[0];
		   	    	$fdisplay(file1, "%d\t%d\t%d\t%d\t%d\t%d", 0, CIN, A, B, S, COUT);
		    		# (DELAY);
				end
	    	else
            	for (j = i+1; j < N; j = j+1) // (7+6+5+4+3+2+1)*2 = 56 state => 55 switching pattern
                    begin
                        {B, A, CIN} = REG_DATA[i];
                        $fdisplay(file1, "%d\t%d\t%d\t%d\t%d\t%d", i, CIN, A, B, S, COUT);
                        # (DELAY);

                        {B, A, CIN} = REG_DATA[j];
                        $fdisplay(file1, "%d\t%d\t%d\t%d\t%d\t%d", j, CIN, A, B, S, COUT);
                        # (DELAY);
                	end
               
		end

    $fclose(file1);
//**************************************Add CLK: disenable******************************************
    $vcdplusoff(U1);
//**************************************************************************************************
    $finish;
  end

initial
  begin
    #(200*DELAY);
    $finish;
  end

endmodule











