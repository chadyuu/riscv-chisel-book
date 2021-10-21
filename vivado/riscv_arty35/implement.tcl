if { [llength $argv] == 0 } {
    error "Project name must be specified."
}

set project_name [lindex $argv 0]
set bd_name [lindex $argv 1]

open_project project/$project_name

update_compile_order -fileset sources_1
reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

write_hw_platform -fixed -force  -include_bit -file ./${bd_name}_wrapper.xsa
