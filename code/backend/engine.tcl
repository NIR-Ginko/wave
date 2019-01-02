package require Tk;

namespace eval Wave-engine {

	# G-code Wave generator.
	proc GCE {max_feed_depth min_feed_depth length_of_wave_lever panel_size_by_x panel_size_by_y distance_between_lines} {
		#.work_panel.code_edit_entry delete 1 end;
		.work_panel.code_edit_entry insert end "G0 X0 Y0 F1000\nM03\n"; # Go to start position. Turn the spindle on.
		.work_panel.code_edit_entry insert end "G1 X0 Y0 Z$max_feed_depth F300\n";

		global steps_by_x;
		global steps_by_y;
		set steps_by_x [expr $panel_size_by_x / $length_of_wave_lever]; # Count of steps for X coord. # Vse s drobnoi chast'yu.
		set steps_by_y [expr $panel_size_by_y / $distance_between_lines]; # Count of steps for Y coord. # Vse s drobnoi chast'yu.

		.work_panel.code_edit_entry insert end "G1 X$length_of_wave_lever Y0 Z$min_feed_depth F800\n";

		if { [expr $length_of_wave_lever * 2] < $panel_size_by_x} {
			.work_panel.code_edit_entry insert end "G1 X[expr $length_of_wave_lever * 2] Y0 F800\n";
		} else {
			tk_messageBox -message [::msgcat::mc "Doubled value of the length of wave lever is greater than panel size."] -title [::msgcat::mc "Error!"];
			.work_panel.code_edit_entry insert end "G1 XError Y0 F800\n";
		}

		.work_panel.code_edit_entry insert end "M05\nM02\n"; # Turn the spindle off. End of the program.
		return 1;
	}

	# DXF Wave generator.
	proc DXFE {} {
		return 1;
	}

}
