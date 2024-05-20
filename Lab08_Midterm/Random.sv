class Random;
rand bit [7:0] first_8_bits;
rand bit [7:0] second_8_bits;
rand bit [7:0] third_8_bits;
rand bit [7:0] fourth_8_bits;
rand bit reset;
rand bit [31:0] data_in;
rand bit Wr_enable;
rand bit Read_enable;

constraint first {first_8_bits inside {[100:230]};}
constraint second {second_8_bits inside {[200:255]};}
constraint third {third_8_bits dist {[0:100] := 3 , [100:200] :=6 , [200:255] :=1}; }

constraint fourth {if(first_8_bits > 150)
{ fourth_8_bits inside {[0:50]};}
 else {
	fourth_8_bits inside {[0:255]};
}
}

constraint rd_enable{Read_enable dist {0 :=5 , 1 := 5};}
constraint wr_enable{Wr_enable dist {0 :=2 , 1 := 3};}
constraint data {data_in == {fourth_8_bits,third_8_bits,second_8_bits,first_8_bits};}

endclass
