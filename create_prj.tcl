# create project
open_project -reset template

# set top function
set_top template

# add files
add_files ./srcs/template.cpp
add_files ./srcs/template.hpp
add_files -tb ./srcs/template_test.cpp

# create solution
open_solution -flow_target vitis solution
set_part {xcu280-fsvh2892-2L-e}
create_clock -period 300.000000MHz -name default

config_rtl -kernel_profile

config_dataflow -strict_mode warning

config_rtl -deadlock_detection sim

config_interface -m_axi_conservative_mode=1

config_interface -m_axi_addr64

config_interface -m_axi_auto_max_ports=0
config_export -format xo -ipname template

csynth_design

close_project
puts "HLS completed successfully"
exit
