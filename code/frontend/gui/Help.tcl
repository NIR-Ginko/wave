toplevel .help_window;
wm title .help_window "Wave help";

pack [frame .help_window.help_frame] -fill both; # Area to place controls.

# Initiate GUI.
grid rowconfigure .help_window.help_frame 2 -weight 1 -minsize 1
grid columnconfigure .help_window.help_frame 2 -weight 1 -minsize 1

# Create and configure GUI elements.
grid [ttk::treeview .help_window.help_frame.help_tree] -row 0 -column 0 -sticky nw;
.help_window.help_frame.help_tree heading #0 -text [::msgcat::mc "Help contents"];
grid [button .help_window.help_frame.select_help_file_button -text "Select"] -row 1 -column 0 -sticky nw;
grid [button .help_window.help_frame.close_help_button -text "Close" -command {destroy .help_window}] -row 1 -column 0 -sticky ne;
grid [text .help_window.help_frame.help_text -width 40 -height 40] -row 0 -rowspan 2 -column 1 -sticky nw;

foreach HelpFile [glob -nocomplain -directory "./doc/" *] { # Create list of help files.
	if { [file isdirectory $HelpFile] } {
		.help_window.help_frame.help_tree insert {} end -id "$HelpFile" -text "$HelpFile";
	} else {
		.help_window.help_frame.help_tree insert {} end -id "$HelpFile" -text "$HelpFile";
	}
}
