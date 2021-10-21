if { [llength $argv] < 3 } {
    error "Project name must be specified."
}
set project_name [lindex $argv 0]
set bd_name [lindex $argv 1]
set part [lindex $argv 2]

create_project $project_name project

set_param board.repoPaths [concat [file join $::env(HOME) {.Xilinx/Vivado/} [version -short] {xhub/board_store}] [get_param board.repoPaths]]
set_property BOARD_PART_REPO_PATHS [get_param board.repoPaths] [current_project]

set_property BOARD_PART $part [current_project]
# set_property ip_repo_paths $ip_repo_path_list [get_filesets sources_1]
# update_ip_catalog

add_files ./src/riscv.v -fileset [get_filesets sources_1]
add_files ./src/top.sv -fileset [get_filesets sources_1]
add_files ./src/top_vivado.v -fileset [get_filesets sources_1]

add_files ./src/pins.xdc -fileset [get_filesets constrs_1]
add_files ./src/debug.xdc -fileset [get_filesets constrs_1]

source ./${bd_name}.tcl
make_wrapper -top -fileset sources_1 -import [get_files project/$project_name.srcs/sources_1/bd/${bd_name}/${bd_name}.bd]