module Phaser(input clk, input rst, input [3:0] comp1, input [3:0] comp2, output reg out1, output reg out2);
	reg [3:0] count;
	reg dir;
	reg check1;
	reg check2;
	always @ (posedge clk) begin
		if (rst) begin
			count <= 4'b0000;
			out1 <= 1'b0;
			out2 <= 1'b0;
			dir <= 1'b0;
			check1 <= 1'b0;
			check2 <= 1'b0;
		end else begin
			if ((count == 4'b1111) && (dir == 1'b0))
				dir <= 1'b1;
			else if ((count == 4'b0000) && (dir == 1'b1))
				dir <= 1'b0;
			else if (dir == 1'b0)
				count <= count + 4'b0001;
			else
				count <= count - 4'b0001;
			if ((count == comp1) && (check1 == 1'b0)) begin
				out1 <= ~out1;
				check1 <= ~check1;
			end else if ((count == comp1) && (check1 == 1'b1))
				check1 <= ~check1;
			if ((count == comp2) && (check2 == 1'b0)) begin
				out2 <= ~out2;
				check2 <= ~check2;
			end else if ((count == comp2) && (check2 == 1'b1))
				check2 <= ~check2;
		end
	end
endmodule
