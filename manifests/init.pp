# Class: preseed
#
# This module manages preseed. This empty class should be
# declared in order to define module dependencies
#
# Parameters: none
#
# Actions: none
#
# Requires: preseed::setup
#
class preseed {
	
	# Require the module to be set-up
	require preseed::setup
}