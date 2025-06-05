set report_default_significant_digits 6 ;
set link_path "./../ref/lib/stdcell_rvt/saed32rvt_ss0p7vn40c.db"

read_verilog "./../ICCII/results/seq_det.routed.v"
link_design
current_design seq_det


read_sdc ./../CONSTRAINTS/seq_det.sdc 

read_parasitics "./../ICCII/results/seq_det_func::nom.spef.p2_125.spef"

update_timing -full

report_timing
report_design


check_timing -verbose > ./reports/check_timing/check_timing.p2_report
report_global_timing > ./reports/timing/report_global_timing.p2_report
report_clock -skew -attribute > ./reports/clock/report_clock.p2_report
report_analysis_coverage > ./reports/analysis_coverage/report_analysis_coverage.p2_report
report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net  > ./reports/timing/report_timing.p2_report
