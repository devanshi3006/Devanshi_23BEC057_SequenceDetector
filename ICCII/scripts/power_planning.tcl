#######################################################################################
## Power-planning - To build Power Delivery Network (PDN)
## #####################################################################################
#
############################################################################
### Step 1: to_create power/ground nets and to_connect power/ground nets :-
##############################################################################

#to create power nets

create_net -power {VDD}
create_net -ground {VSS}

## to connect power/ground_nets
#
connect_pg_net -all_blocks -automatic


#################################################################################
### step 2: to create power and ground ring patterns
#################################################################################
###
#scenario1:

create_pg_ring_pattern core_ring_pattern -horizontal_layer M7 -horizontal_width .4 -horizontal_spacing .3 -vertical_layer M8 -vertical_width .4 -vertical_spacing .3

set_pg_strategy core_power_ring -core -pattern {{name : core_ring_pattern}{nets : {VDD VSS}}{offset : {.5 .5}}}

compile_pg -strategies core_power_ring

###############################################################################
### step 3: to create pg mesh pattern
################################################################################


create_pg_mesh_pattern mesh -layers { {{vertical_layer: M6}{width: .34} {spacing: interleaving}{pitch: 5} {offset: .5}} {{horizontal_layer: M7}{width: .38} {spacing: interleaving} {pitch: 5} {offset: .5}} {{vertical_layer: M8}{width: .38} {spacing: interleaving}{pitch: 5} {offset: .5}}}

set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core -extension {stop: innermost_ring}

#set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core -extension {{{side: 1 2} {direction: L T} {stop: innermost_ring}}}

compile_pg -strategies core_mesh
connect_pg_net -all_blocks -automatic

###################################################
###step 4 : to create std cell power rail pattern
#######################################################

create_pg_std_cell_conn_pattern std_cell_rail -layers {M1} -rail_width 0.06

set_pg_strategy rail_strat -core -pattern {{name: std_cell_rail} {nets: VDD VSS} }

compile_pg -strategies rail_strat
#compile_pg

##########################################################
### step 5 : To save block and Save lib
#############################################################
## "save_block"  will save block as the deign name (full_adder.design) by default
#
save_block

## "save_block -as <preferred name>" to save the block in user preferred name
##
## "save_lib" will save library as created already

save_lib

