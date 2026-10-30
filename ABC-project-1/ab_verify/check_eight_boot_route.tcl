cd [file normalize [file join [file dirname [info script]] td_static]]
import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.prj -noanalyze
import_db ABC-project-1_pr.db
drc_check -route -verbose
report_route_status -drc -file eight_boot_final_route_drc.rpt
puts FINAL_ROUTE_DRC_CHECKED
exit
