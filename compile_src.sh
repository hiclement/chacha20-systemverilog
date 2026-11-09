#!/bin/bash

export PROJECTNAME="."
							    
echo "======================================================="
echo "the project location is : $PROJECTNAME"
echo "removing libs"

vdel -lib $PROJECTNAME/LIB/LIB_RTL -all
vdel -lib $PROJECTNAME/LIB/LIB_BENCH -all

echo "creating library "

vlib $PROJECTNAME/LIB/LIB_RTL
vmap LIB_RTL $PROJECTNAME/LIB/LIB_RTL
vlib $PROJECTNAME/LIB/LIB_BENCH
vmap LIB_BENCH $PROJECTNAME/LIB/LIB_BENCH

# compilation des fichiers sources
echo "compile vhdl sources"
echo "vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/arx.sv" 
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/chacha_pck.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/rotation_pck.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/arx.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/quarter_round.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/round_colonne.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/rotation.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/registre_d.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/reg512.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/additionneur.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/compteur_init.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/recollage_before_mux.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/xor_module.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/chacha_bloc.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/FSM.sv | grep Error
vlog -sv +acc -svinputport=net -work LIB_RTL $PROJECTNAME/SRC/RTL/chacha20_top.sv | grep Error


# Compilation des fichiers TB
echo "compile vhdl test bench"
echo "vlog -sv +acc -svinputport=net -L LIB_RTL -work LIB_BENCH $PROJECTNAME/SRC/BENCH/arx_tb.sv"
#vlog -sv +acc -svinputport=net -L LIB_RTL -work LIB_BENCH $PROJECTNAME/SRC/BENCH/quarter_round_tb.sv
#vlog -sv +acc -svinputport=net -L LIB_RTL -work LIB_BENCH $PROJECTNAME/SRC/BENCH/round_tb.sv
#vlog -sv +acc -svinputport=net -L LIB_RTL -work LIB_BENCH $PROJECTNAME/SRC/BENCH/registre_d_tb.sv
vlog -sv +acc -svinputport=net -L LIB_RTL -work LIB_BENCH $PROJECTNAME/SRC/BENCH/chacha20_top_tb.sv


# lancement du simulateur
echo "compilation finished"
echo "start simulation..."



# ATTENTION un seul VSIM decommenté à la fois! (facultatif)
#vsim -L lib_rtl lib_bench.round_tb
vsim -L lib_rtl lib_bench.chacha20_top_tb
echo "======================================================="
