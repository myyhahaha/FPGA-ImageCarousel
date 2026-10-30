import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.prj
elaborate -top ab_video_diag_top
read_adc ../../abc_hdmi_merged.adc
read_sdc ../../abc_hdmi_diag.sdc
optimize_rtl
report_area -file rtl.area
export_db ABC-project-1_rtl.db
optimize_gate -packarea ABC-project-1_gate.area
legalize_phy_inst
update_timing
report_timing_status -file ABC-project-1_gate.ts
report_timing_summary -file ABC-project-1_gate.timing
export_db ABC-project-1_gate.db
puts "SYNTHESIS_PASS"
exit
