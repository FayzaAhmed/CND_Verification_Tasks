To compile and run use this commands:

vcs -sverilog -cm line+cond+fsm+tgl TB_top.sv TB.sv interface.sv FIFO.v
./simv -cm line+cond+tgl
urg -dir simv.vdb
verdi -cov -covdir simv.vdb &

