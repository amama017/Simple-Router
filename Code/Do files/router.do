vsim ArchProject.router
# vsim ArchProject.router 
# Loading C:\FPGAdv72PS\Modeltech\win32/../std.standard
# Loading C:\FPGAdv72PS\Modeltech\win32/../ieee.std_logic_1164(body)
# Loading C:\FPGAdv72PS\Modeltech\win32/../ieee.std_logic_arith(body)
# Loading C:\FPGAdv72PS\Modeltech\win32/../ieee.std_logic_unsigned(body)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.router(rtl)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.register_8bit(rtl)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.buffer1(rtl)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.demux(rtl)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.fifo(rtl)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.fifocon(rtl)
# Loading C:\FPGAdv72PS\Modeltech\win32/../ieee.numeric_std(body)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.block_ram(rtl)
# Loading D:/Uni/3rd/Second Term/Adv. Arch/Project/ArchProject.rrs(rtl)
add wave sim:/router/rst
add wave sim:/router/rclock
add wave sim:/router/wclock
add wave sim:/router/wr1
add wave sim:/router/wr2
add wave sim:/router/wr3
add wave sim:/router/wr4
add wave sim:/router/rq1
add wave sim:/router/rq2
add wave sim:/router/rq3
add wave sim:/router/rq4
add wave sim:/router/datai1
add wave sim:/router/datai2
add wave sim:/router/datai3
add wave sim:/router/datai4
add wave sim:/router/datao1
add wave sim:/router/datao2
add wave sim:/router/datao3
add wave sim:/router/datao4
force -freeze sim:/router/rst 1 0
force -freeze sim:/router/rclock 1 0, 0 {50 ns} -r 100
force -freeze sim:/router/wclock 1 0, 0 {50 ns} -r 100
force -freeze sim:/router/wr1 0 0
force -freeze sim:/router/wr2 0 0
force -freeze sim:/router/wr3 0 0
force -freeze sim:/router/wr4 0 0
force -freeze sim:/router/rq1 0 0
force -freeze sim:/router/rq2 0 0
force -freeze sim:/router/rq3 0 0
force -freeze sim:/router/rq4 0 0
force -freeze sim:/router/datai1 10 0
force -freeze sim:/router/datai2 20 0
force -freeze sim:/router/datai3 30 0
force -freeze sim:/router/datai4 40 0
run
force -freeze sim:/router/rst 0 0
run
force -freeze sim:/router/wr2 1 0
run
force -freeze sim:/router/wr2 0 0
force -freeze sim:/router/wr1 1 0
run
force -freeze sim:/router/wr1 0 0
run
force -freeze sim:/router/rq1 1 0
run
run
force -freeze sim:/router/rq1 0 0
run
run
run
run
force -freeze sim:/router/rq1 1 0
run
force -freeze sim:/router/rq1 0 0
run
run
run
force -freeze sim:/router/wr2 1 0
run
force -freeze sim:/router/wr2 0 0
run
force -freeze sim:/router/datai1 11 0
force -freeze sim:/router/wr1 1 0
run
force -freeze sim:/router/wr1 0 0
run
force -freeze sim:/router/datai3 32 0
force -freeze sim:/router/datai4 42 0
force -freeze sim:/router/wr3 1 0
force -freeze sim:/router/wr4 1 0
run
force -freeze sim:/router/wr3 0 0
force -freeze sim:/router/wr4 0 0
run
force -freeze sim:/router/rq1 1 0
run
force -freeze sim:/router/rq1 0 0
force -freeze sim:/router/rq3 1 0
force -freeze sim:/router/rq4 1 0
run
force -freeze sim:/router/rq3 0 0
force -freeze sim:/router/rq4 0 0
run
run
run
force -freeze sim:/router/rq3 1 0
force -freeze sim:/router/rq4 1 0
run
force -freeze sim:/router/rq3 0 0
force -freeze sim:/router/rq4 0 0
run
run
force -freeze sim:/router/rq3 1 0
force -freeze sim:/router/rq4 1 0
run
force -freeze sim:/router/rq3 0 0
force -freeze sim:/router/rq4 0 0
run
run
run
force -freeze sim:/router/rq4 1 0
run
force -freeze sim:/router/rq4 0 0
run
run
run
force -freeze sim:/router/rq3 1 0
run
force -freeze sim:/router/rq3 0 0
run
run
run
force -freeze sim:/router/rq1 1 0
run
force -freeze sim:/router/rq1 0 0
run
run
noforce sim:/router/rq1
force -freeze sim:/router/rq1 1 0
run
run
force -freeze sim:/router/rq1 0 0
run
run
force -freeze sim:/router/rq2 1 0
run
force -freeze sim:/router/rq2 0 0
run
run
run