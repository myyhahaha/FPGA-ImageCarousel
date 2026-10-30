cd [file normalize [file join [file dirname [info script]] td_static]]
import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.prj
elaborate -top hdmi_top
optimize_rtl
optimize_gate -macrosim ../hdmi_macro.v -mapsim ../hdmi_map.v
puts VIDEO_EXPORT_PASS
exit
