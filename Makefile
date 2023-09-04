PRJ_NAME ?= template

VITIS_HLS_INCLUDE_PATH = /tools/Xilinx/Vitis_HLS/2023.1/include/

CARGS += -I
CARGS += $(VITIS_HLS_INCLUDE_PATH)

cexe =  $(PRJ_NAME)
cobj += build/$(PRJ_NAME).o

.PHONY: all clean creation

all:
	-@vitis_hls -f create_prj.tcl

csim: $(cexe)
	-@mkdir -p build

$(cexe): $(cobj) srcs/$(PRJ_NAME)_tb.cpp
	g++ $(CARGS) $^ -o $@

$(cobj): srcs/$(PRJ_NAME).cpp srcs/$(PRJ_NAME).hpp
	-@mkdir -p build
	g++ $(CARGS) -c -Wall -o "$@" "$<"


creation:
	-@sed -i 's/template/$(PRJ_NAME)/g' create_prj.tcl
	-@sed -i 's/template/$(PRJ_NAME)/g' srcs/template.cpp
	-@sed -i 's/TEMPLATE/$(PRJ_NAME, UC)/g' srcs/template.hpp
	-@sed -i 's/template/$(PRJ_NAME)/g' srcs/template.hpp
	-@sed -i 's/template/$(PRJ_NAME)/g' srcs/template_tb.cpp
	-@rename 's/template/$(PRJ_NAME)/' srcs/*


clean:
	-@rm -rf $(PRJ_NAME)
	-@rm -rf build
	-@rm -f $(PRJ_NAME)
	-@rm -rf *.log
