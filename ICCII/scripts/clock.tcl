#####################################################
#pre-clock sanity checks
####################################################

check_design -checks pre_clock_tree_stage


###################################################
##        CTS using CCD  commands
####################################################
##
##stage 1:
##

synthesize_clock_tree
##stage 2:
#
set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value false
set_app_options -name clock_opt.flow.enable_ccd -value true

clock_opt -to build_clock
#stage 3:
###
#
clock_opt -from route_clock -to route_clock
clock_opt

###########################################################
###  to report qor the respective CTS
############################################################
#
#report_clock_qor
#report_clock_qor -largest 2 -show_verbose_paths
#report_clock_qor -largest 2 -show_verbose_paths > cts_ccd.rpt

##########################################################
#  to save the block
########################################################

save_block -as seq_det_cts_CCD
save_lib



