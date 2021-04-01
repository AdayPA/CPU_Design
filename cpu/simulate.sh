#!/bin/bash
rm a.out
iverilog alu.v cd.v uc.v memprog.v componentes.v cpu.v cpu_tb.v
vvp a.out
