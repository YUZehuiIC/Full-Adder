// -----------------------------------------------------------------------------------------
// Version | Programmer                                     | Date       | Remark   
// -----------------------------------------------------------------------------------------
// V1      | Dr Kwen-Siong Chong (kschong@ntu.edu.sg)       | 31/07/2013 | Initial version
// -----------------------------------------------------------------------------------------  
//
// The code is a behavioural code for a full adder
// The code is for teaching purpose in the NTU-TUM class, NM6008. 

module FullAdder (  //inputs
					CIN,
					A,
					B,
					//outputs
					S, COUT);

input CIN;
input A;
input B;

output S;
output COUT;

assign S = A ^ B ^ CIN;
assign COUT = (A & B) | (CIN & (A ^ B));

endmodule