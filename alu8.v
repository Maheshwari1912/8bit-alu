`timescale 1ns / 1ps

module alu8(
input [7:0]a,input [7:0]b, input [3:0]select,
output reg [7:0]result,
output reg carry_flag,
output reg overflow_flag,
output reg zero_flag,
output reg negative_flag
    );
  always@(*)begin
  carry_flag=0;
  overflow_flag=0;
  zero_flag=0;
  negative_flag=0;
  
  case(select)
    4'b0000:begin
    {carry_flag, result} = a+b;
    overflow_flag=(a[7] == b[7])&&(a[7]!=result[7]);
    end
     4'b0001:begin
    {carry_flag, result} = a-b;
    overflow_flag=(a[7] != b[7])&&(a[7]!=result[7]);
    end
    4'b0010:result=a*b;
    4'b0011:begin
    if(b!=0)begin
     result=a/b;
     end
     else
     result=8'b0;
     end
     4'b0100:result=a&b;
     4'b0101:result=a|b;
     4'b0110:result=~(a&b);
     4'b0111:result=~(a|b);
     4'b1000:result=a^b;
     4'b1001:result=a~^b;
     4'b1010:result=~a;
     default:result=8'b0;
     endcase
     if(result == 8'b00000000)zero_flag=1;
     if(result[7]==1) negative_flag=1;
     end    
endmodule
