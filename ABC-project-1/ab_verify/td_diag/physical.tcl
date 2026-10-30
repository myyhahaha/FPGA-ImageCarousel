import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.prj -noanalyze
import_db ABC-project-1_gate.db
set_param place seed 2
place
update_timing -mode manhattan
report_timing_summary -file ABC-project-1_place.timing
report_area -io_info -file ABC-project-1_phy.area
export_db ABC-project-1_place.db
route
update_timing -mode final
report_timing_status -file ABC-project-1_phy.ts
report_timing_summary -file ABC-project-1_pr.timing
export_db ABC-project-1_pr.db
bitgen -bit ABC-video-diagnostic.bit
puts "BITSTREAM_GENERATED"
exit

