verdiSetActWin -dock widgetDock_<Decl._Tree>
simSetSimulator "-vcssv" -exec "/home/puneet/RTL2GDSII/WORK/simv" -args "verdi"
debImport "-dbdir" "/home/puneet/RTL2GDSII/WORK/simv.daidir"
wvCreateWindow
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 {/home/puneet/RTL2GDSII/WORK/novas.fsdb}
verdiWindowResize -win $_Verdi_1 "318" "82" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
nsMsgSwitchTab -tab general
debImport "/home/puneet/RTL2GDSII/WORK/full_adder_tb.v" -path \
          {/home/puneet/RTL2GDSII/WORK}
nsMsgSwitchTab -tab general
debLoadSimResult /home/puneet/RTL2GDSII/WORK/novas.fsdb
srcDeselectAll -win $_nTrace1
srcSelect -signal "A" -line 4 -pos 1 -win $_nTrace1
wvCreateWindow
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave3
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {4 8 2 1 1 1}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
wvSetPosition -win $_nWave4 {("G1" 0)}
wvOpenFile -win $_nWave4 {/home/puneet/RTL2GDSII/WORK/novas.fsdb}
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave4
verdiWindowResize -win $_Verdi_1 "0" "23" "1536" "801"
verdiWindowResize -win $_Verdi_1 "318" "82" "900" "700"
verdiWindowResize -win $_Verdi_1 "0" "23" "1536" "801"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {24 30 2 11 1 1}
srcDeselectAll -win $_nTrace1
debExit
