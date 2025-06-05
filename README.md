# RTL TO GDSII: SEQUENCE DETECTOR 110
## INTRODUCTION:
A sequence detector in digital electronics is a circuit that generates an output signal when a specific sequence of input bits is detected.For combinational designs, the output value completely depends on the present value of the inputs and for sequential designs, output value not only depends on present input but also depends on its previously stored value i.e. past behavior of the design. These sequential designs are formally knowns as finite-state machines that have a fixed number of states.
                                                     ![image](https://github.com/user-attachments/assets/9ccd4b92-4cb2-42e7-9027-08aec69b2271)

Both Mealy and Moore machines can be used to design sequence detector logic. Further, these machines are classified as:
1. Overlapping sequence detector – Final bits of the sequence can be the start of another sequence. Thus, it allows overlap.
2. Non-overlapping sequence detector – Once sequence detection is completed, another sequence detection can be started without any overlap.
   ![image](https://github.com/user-attachments/assets/5109a3cd-937b-4a6d-b6a0-746fc4ff92c4)

## ENVIRONMENT 
**ROCKY LINUX**: The operating system environment in which Synopsys tools are employed
## TOOLS USED
**VERILOG HDL**: The RTL of the sequence detector was designed using the Hardware Description Language.

**Synopsys VCS**: Combines and models  RTL-level Verilog code

**Verdi**: Waveform viewer for debugging simulation results

## FLOW OF THE PROJECT
![FINITE STATE MACHINE](https://github.com/user-attachments/assets/e3ab79ac-12c7-47ec-a586-4f48c6a2fabb)

## IMPORTANT COMMANDS
### ENVIRONMENT SETUP
### Checks to see if the Synopsys tools are installed successfully and in the system path.
``` which vcs
which verdi
which dc_shell
which icc2_shell
which pt_shell
```
### Shows the graphical user interface, Verdi, ICC2 shell, or Design Compiler shell.
``` verdi
icc2_shell
dc_shell
start_gui
```
### RTL SIMULATION
#### Compiles the RTL Verilog code:
```vcs -full64 RTL_Verilog_Code/seq_det.v -debug_access+all -lca -kdb```
#### Compiles the testbench code:
```vcs -full64 Testbench/seq_det_tb.v -debug_access+all -lca -kdb```
#### Executes the compiled simulation:
```./simv```
#### Prompts Verdi to open the waveform file for signal analysis:
```verdi -ssf novas.fsdb -nologo```
#### OUTPUT:
![verdi](https://github.com/user-attachments/assets/bb5a7e6c-2622-4c16-8c02-98f34f57df43)
### SYNTHESIS USING DESIGN COMPILER (DC)
#### Starts the Design Compiler shell:
```dc_shell```
#### Modifies timing constraints, such as clock period:
```vi constraints/seq_det.sdc```
#### Executed the DC Script:
```source run_dc.tcl```
#### Launches the GUI version of Design Compiler:
```start_gui```
![image](https://github.com/user-attachments/assets/3b23b6ee-7d99-4787-b7e7-cb0d5776d24a)
![image](https://github.com/user-attachments/assets/2a4b4944-175d-49f0-8d96-604fa54d3b1f)


#### Generates reports which provides important parameters for synthesis:
```
report_qor
report_timing
```
![image](https://github.com/user-attachments/assets/142619b0-f71f-4403-bdea-0952b492339c)
![image](https://github.com/user-attachments/assets/80fa1642-4565-46e9-b2d5-05156d707ba4)


![image](https://github.com/user-attachments/assets/a010b44a-835d-4a2a-9bf0-4b4bfaa00d03)

Having maximum leaf cell count as 17 with dc slack as 0.42, 6th case is used for synthesis.
All these values are taken from report_qor and report_timing.

### PHYSICAL DESIGN SYNTHESIS USING ICC2
#### Launches the ICC2 shell and its GUI:
```
icc2_shell
start_gui
```
### Creates reports for time, power consumption, and result quality:
```
report_qor
report_timing
report_power
```
**STEP 1: Floorplanning:**
```
set PDK_PATH ./../ref
create_lib -ref_lib $PDK_PATH/lib/ndm/saed32rvt_c.ndm SEQ_DET_LIB
read_verilog {./../DC/results/seq_det.mapped.v} -library SEQ_DET_LIB -design seq_det -top seq_det
#open the lib and block after saving
open_lib SEQ_DET_LIB
open_block SEQ_DET
initialize_floorplan -shape R -core_offset 1
set_individual_pin_constraints -ports [get_ports clk] -sides 2
place_pins -self
create_placement -floorplan -effort very_low
save_block -as SEQ_DET
save_lib
```
**STEP 2: Powerplanning:**
```

create_net -power {VDD}
create_net -ground {VSS}
connect_pg_net -all_blocks -automatic
create_pg_ring_pattern core_ring_pattern -horizontal_layer M7 -horizontal_width .4 -horizontal_spacing .3 -vertical_layer M8 -vertical_width .4 -vertical_spacing .3

set_pg_strategy core_power_ring -core -pattern {{name : core_ring_pattern}{nets : {VDD VSS}}{offset : {.5 .5}}}

compile_pg -strategies core_power_ring

create_pg_mesh_pattern mesh -layers { {{vertical_layer: M6}{width: .34} {spacing: interleaving}{pitch: 5} {offset: .5}} {{horizontal_layer: M7}{width: .38} {spacing: interleaving} {pitch: 5} {offset: .5}} {{vertical_layer: M8}{width: .38} {spacing: interleaving}{pitch: 5} {offset: .5}}}

set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core -extension {stop: innermost_ring}

#set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core -extension {{{side: 1 2} {direction: L T} {stop: innermost_ring}}}

compile_pg -strategies core_mesh
connect_pg_net -all_blocks -automatic

create_pg_std_cell_conn_pattern std_cell_rail -layers {M1} -rail_width 0.06
set_pg_strategy rail_strat -core -pattern {{name: std_cell_rail} {nets: VDD VSS} }
compile_pg -strategies rail_strat
#compile_pg
save_block
save_lib
```
**STEP 3: Placement:**
```
set PDK_PATH ./../ref
set mode1 "func"
set corner1 "nom"
set scenario1 "${mode1}::${corner1}"
remove_modes -all; remove_corners -all; remove_scenarios -all
create_mode $mode1
create_corner $corner1
create_scenario -name func::nom -mode func -corner nom
current_mode func
current_scenario func::nom

source ./../CONSTRAINTS/seq_det.sdc
set_dont_use [get_lib_cells */FADD*]
set_dont_use [get_lib_cells */HADD*]
set_dont_use [get_lib_cells */AO*]
set_dont_use [get_lib_cells */OA*]
#set_dont_use [get_lib_cells */NAND*]
set_dont_use [get_lib_cells */XOR*]
#set_dont_use [get_lib_cells */NOR*]
set_dont_use [get_lib_cells */XNOR*]
set_dont_use [get_lib_cells */MUX*]

current_corner nom
current_scenario func::nom

set parasitic1 "p1"
set tluplus_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set layer_map_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"
set parasitic2 "p2"
set tluplus_file$parasitic2 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set layer_map_file$parasitic2 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"
read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1
read_parasitic_tech -tlup $tluplus_filep2 -layermap $layer_map_filep2 -name p2
set_parasitic_parameters -late_spec $parasitic1 -early_spec $parasitic2
set_app_options -name place.coarse.continue_on_missing_scandef -value true

place_pins -self
place_opt
legalize_placement

save_block -as seq_det_placement
save_lib
```
**STEP 4: Clock tree synthesis**
```
check_design -checks pre_clock_tree_stage
synthesize_clock_tree
set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value false
set_app_options -name clock_opt.flow.enable_ccd -value true

clock_opt -to build_clock
clock_opt -from route_clock -to route_clock
clock_opt
save_block -as seq_det_cts_CCD
save_lib
```
**STEP 5: Routing**
```
set_app_options -name route.global.timing_driven -value true
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.track.crosstalk_driven -value true
set_app_options -name route.detail.timing_driven -value true
set_app_options -name route.detail.save_after_iterations -value 0
set_app_options -name route.detail.force_max_number_iterations -value false
set_app_options -name route.detail.antenna -value true
set_app_options -name route.detail.antenna_fixing_preference -value use_diodes
set_app_options -name route.detail.diode_libcell_names -value */ANTENNA_RVT
route_global
route_track
route_detail
route_opt
write_verilog ./results/seq_det.routed.v
write_sdc -output ./results/seq_det.routed.sdc
write_parasitics -format spef -output ./results/seq_det_${scenario1}.spef
```
#### Write the below commands to source the files at once:
```
source scripts\power_planning.tcl
source scripts\placement.tcl
source scripts\clock.tcl
source scripts\route.tcl
```
#### RESULTS AFTER STEP 1 (FLOORPLANNING):
![image](https://github.com/user-attachments/assets/868c76f7-eba1-4a6c-95b9-3750c9d4cee6)
![image](https://github.com/user-attachments/assets/80e2116a-4095-4035-8a85-5dced517c8eb)
![image](https://github.com/user-attachments/assets/a07070a8-6f50-4c96-a2a1-452c88df9cb0)

























