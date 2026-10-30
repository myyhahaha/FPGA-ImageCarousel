cd [file normalize [file join [file dirname [info script]] td_static]]
import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.prj
elaborate -top ab_image_cache_ctrl
optimize_rtl
optimize_gate -mapsim ../cache_map.v
puts CACHE_EXPORT_PASS
exit
