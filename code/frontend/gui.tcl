package require Tk;
package require Thread;

namespace eval Wave-GUI {

	proc StartGUI {} {
		MainWindow
	}

	proc MainWindow {} {
		puts [::msgcat::mc "Initiation of GUI elements..."];

		option add *Font {Sans 9 normal};

		# Create toplevel menu and its toplevel submenus.
		menu .main_menu;
		menu .main_menu.file -tearoff 1;
#		menu .main_menu.file.open -tearoff 1;
		menu .main_menu.settings -tearoff 1;
		menu .main_menu.help -tearoff 1;

		# Assign names to toplevel submenus.
		.main_menu add cascade -label [::msgcat::mc "File"] -menu .main_menu.file -underline 0;
		.main_menu add cascade -label [::msgcat::mc "Settings"] -menu .main_menu.settings -underline 0;
		.main_menu add cascade -label [::msgcat::mc "Help"] -menu .main_menu.help -underline 0;

		# Initiate "File" menu.
#		.main_menu.file add cascade -label [::msgcat::mc "Open"] -menu .main_menu.file.open -underline 0;
#		.main_menu.file add separator;
		.main_menu.file add command -label [::msgcat::mc "Exit"] -accelerator "Ctrl-Q" -underline 0 -command exit;

		# Initiate "Settings" menu.
		.main_menu.settings add command -label [::msgcat::mc "Settings"] -accelerator "Ctrl-Z" -underline 0 -command {return 0};

		# Initiate "Help" menu.
		.main_menu.help add command -label [::msgcat::mc "Help"] -accelerator "F1" -underline 0 -command Wave-GUI::Help;
		.main_menu.help add command -label [::msgcat::mc "Support"] -accelerator "F2" -underline 0 -command Wave-GUI::Support;
		.main_menu.help add separator;
		.main_menu.help add command -label [::msgcat::mc "About"] -accelerator "F3" -underline 0 -command Wave-GUI::About;

		# Bind hotkeys for menu functions.
		puts [::msgcat::mc "Binding hotkeys..."];
		source "code/frontend/gui/shortcuts.tcl";

		# Create main window.
		wm title . [::msgcat::mc "Wave"];
		. configure -menu .main_menu; # Connect .main_menu with main window.

		pack [frame .settings_panel] -side left -expand 1 -fill both;
		pack [frame .work_panel] -side right -expand 1 -fill both;


		# Initiate first panel.
		grid rowconfigure .settings_panel 18 -weight 1 -minsize 1;
		grid columnconfigure .settings_panel 3 -weight 1 -minsize 1;

		grid [label .settings_panel.fraisa_diameter_label -text [::msgcat::mc "Fraisa diameter: "]] -row 0 -column 0 -sticky nw;
		grid [label .settings_panel.panel_size_by_x_label -text [::msgcat::mc "Panel size by X: "]] -row 1 -column 0 -sticky nw;
		grid [label .settings_panel.panel_size_by_y_label -text [::msgcat::mc "Panel size by Y: "]] -row 2 -column 0 -sticky nw;
		grid [label .settings_panel.distance_between_lines_label -text [::msgcat::mc "Distance between lines: "]] -row 3 -column 0 -sticky nw;
		grid [label .settings_panel.x_margin_label -text [::msgcat::mc "X margin: "]] -row 4 -column 0 -sticky nw;
		grid [label .settings_panel.y_margin_label -text [::msgcat::mc "Y margin: "]] -row 5 -column 0 -sticky nw;
		grid [label .settings_panel.min_feed_depth_label -text [::msgcat::mc "Min feed depth: "]] -row 6 -column 0 -sticky nw;
		grid [label .settings_panel.max_feed_depth_label -text [::msgcat::mc "Max feed depth: "]] -row 7 -column 0 -sticky nw;
		grid [label .settings_panel.radius_label -text [::msgcat::mc "Radius: "]] -row 8 -column 0 -sticky nw;
		grid [label .settings_panel.wave_mistiming_label -text [::msgcat::mc "Wave mistiming: "]] -row 9 -column 0 -sticky nw;
		grid [label .settings_panel.length_of_wave_lever_label -text [::msgcat::mc "Length of wave lever: "]] -row 10 -column 0 -sticky nw;
		grid [label .settings_panel.wave_period_label -text [::msgcat::mc "Wave period: "]] -row 11 -column 0 -sticky nw;
		grid [label .settings_panel.height_idle_label -text [::msgcat::mc "Height idle: "]] -row 12 -column 0 -sticky nw;
		grid [label .settings_panel.feed_rate_label -text [::msgcat::mc "Feed rate: "]] -row 13 -column 0 -sticky nw; # Skorost' rabochei podachi
		grid [label .settings_panel.idle_speed_label -text [::msgcat::mc "Idle speed: "]] -row 14 -column 0 -sticky nw; # Skorost' holostogo hoda.
		grid [label .settings_panel.tiein_speed_label -text [::msgcat::mc "Material tie-in speed: "]] -row 15 -column 0 -sticky nw; # Skorost' vrezki v material.
		grid [label .settings_panel.line_count_in_block_label -text [::msgcat::mc "Line count in block: "]] -row 16 -column 0 -sticky nw;
		grid [label .settings_panel.count_of_blocks_in_lever_label -text [::msgcat::mc "Count of blocks in lever: "]] -row 17 -column 0 -sticky nw;

		global v_panel_size_by_x;
		global v_panel_size_by_y;
		global v_distance_between_lines;
		global v_min_feed_depth;
		global v_max_feed_depth;
		global v_length_of_wave_lever;

		grid [ttk::entry .settings_panel.fraisa_diameter_entry] -row 0 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.panel_size_by_x_entry -text v_panel_size_by_x] -row 1 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.panel_size_by_y_entry -text v_panel_size_by_y] -row 2 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.distance_between_lines_entry -text v_distance_between_lines] -row 3 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.x_margin_entry] -row 4 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.y_margin_entry] -row 5 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.min_feed_depth_entry -text v_min_feed_depth] -row 6 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.max_feed_depth_entry -text v_max_feed_depth] -row 7 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.radius_entry] -row 8 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.wave_mistiming_entry] -row 9 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.length_of_wave_lever_entry -text v_length_of_wave_lever] -row 10 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.wave_period_entry] -row 11 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.height_idle_entry] -row 12 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.feed_rate_entry] -row 13 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.idle_speed_entry] -row 14 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.tiein_speed_entry] -row 15 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.line_count_in_block_entry] -row 16 -column 1 -sticky nw;
		grid [ttk::entry .settings_panel.count_of_blocks_in_lever_entry] -row 17 -column 1 -sticky nw;

		set v_panel_size_by_x 600;
		set v_panel_size_by_y 600;
		set v_distance_between_lines 16;
		set v_min_feed_depth -1;
		set v_max_feed_depth -9;
		set v_length_of_wave_lever 160;

		grid [ttk::checkbutton .settings_panel.dist_b_l_cb -text [::msgcat::mc "Auto"] -variable dist_b_l -onvalue 0 -offvalue 1] -row 3 -column 2 -sticky nw;
		grid [ttk::checkbutton .settings_panel.wave_mistiming_cb -text [::msgcat::mc "Auto"] -variable wave_mistiming -onvalue 0 -offvalue 1] -row 8 -column 2 -sticky nw;

		# Initiate second panel.
		grid rowconfigure .work_panel 18 -weight 1 -minsize 1;
		grid columnconfigure .work_panel 1 -weight 1 -minsize 1;
		grid [button .work_panel.generate_g_code_button -text [::msgcat::mc "Generate G-code"] -command {Wave-engine::GCE $v_max_feed_depth $v_min_feed_depth $v_length_of_wave_lever $v_panel_size_by_x $v_panel_size_by_y $v_distance_between_lines}] -row 0 -column 0 -sticky nw;
		grid [button .work_panel.generate_dxf_button -text [::msgcat::mc "Generate DXF"] -command {Wave-engine::DXFE }] -row 1 -column 0 -sticky nw;
		grid [text .work_panel.code_edit_entry -height 15 -width 20] -row 2 -column 0 -sticky nw;
		#grid [scrollbar .work_panel.sbar_y -orient vertical -command [.work_panel.code_edit_entry yview]] -row 2 -column 0 -sticky ns;
		#grid [scrollbar .work_panel.sbar_x -orient horizontal -command [.work_panel.code_edit_entry xview]] -row 2 -column 0 -sticky nw;
	}

	proc Help {} { source "code/frontend/gui/Help.tcl"; }
	proc Support {} { source "code/frontend/gui/Support.tcl"; }
	proc About {} { source "code/frontend/gui/About.tcl"; }
}
