cd [file normalize [file join [file dirname [info script]] ..]]
import_device eagle_s20.db -package EG4S20BG256
open_project ABC-project-1.al
elaborate -top sdr_as_ram
write_verilog ab_verify/sdr_elaborated.v
optimize_rtl
optimize_gate -macrosim ab_verify/sdr_macro.v -mapsim ab_verify/sdr_map.v
write_verilog ab_verify/sdr_gate.v
write_verilog ab_verify/sdr_formal.v -fm
puts EXPORT_PASS
exit


