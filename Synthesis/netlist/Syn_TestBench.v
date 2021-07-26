
module TestBench ( CIN, A, B, S, COUT );
  input CIN, A, B;
  output S, COUT;
  wire   n5, n6, n7;

  XNR20 U6 ( .A(n5), .B(CIN), .Q(S) );
  CLKIN0 U7 ( .A(n6), .Q(COUT) );
  AOI220 U8 ( .A(B), .B(A), .C(n7), .D(CIN), .Q(n6) );
  CLKIN0 U9 ( .A(n5), .Q(n7) );
  XNR20 U10 ( .A(B), .B(A), .Q(n5) );
endmodule

