cd [file normalize [file join [file dirname [info script]] ..]]
import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.al
elaborate -top hdmi_top
optimize_rtl
optimize_gate -macrosim ab_verify/hdmi_macro.v -mapsim ab_verify/hdmi_map.v
puts VIDEO_EXPORT_PASS
exit
