#!/usr/bin/wish
package require Tcl;
package require msgcat;

	# int main ()... Using procedure instead of plain code allows us to have return codes.
	# Get message catalogs. Selection of correct locale is fully automatic. Don't fucking try to select locale forcefully. OBEY your admin.
	::msgcat::mcload [file join [file dirname [info script]] int];

	puts [::msgcat::mc "Starting Wave..."];

	source "code/backend/engine.tcl";
	source "code/frontend/gui.tcl";
	if { [catch {Wave-GUI::StartGUI}] } { return 1; }
