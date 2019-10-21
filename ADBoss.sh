#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#   This Script is designed for use in JAMF
#
#   This script was designed to check the AD Accounts that have 
#	local Admin permissions and reset them if required
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.1 - 21/10/2019
#
#   - 01/03/2018 - V1.0 - Created by Headbolt
#
#   - 21/10/2019 - V1.1 - Updated by Headbolt
#                           More comprehensive error checking and notation
#
####################################################################################################
#
#   DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################
#
# Set the name of the script for later logging
ScriptName="append prefix here as needed -  - AD Allowed Admins"
#
TargetLocalADAdmins=$4
CurrentLocalADAdmins=$(dsconfigad -show | grep "Allowed admin groups" | cut -c 36-)
#
# AD Domain "Domain Admins" Will be Added By Default, but use the below variable to add any further
# Administrators from any other Domains, these should be specified seperated by comma's 
# with a trailing comma at the end. If not needed use the provided "Blank" entry
# The entire String must be encapsulated in single quotes 
# eg. '"DOMAIN\enterprise admins","DOMAIN2\domain admins",'
#
#ExtraAdmins=','
#
TargetLocalADAdminString=$(Echo domain admins,"$ExtraAdmins""$TargetLocalADAdmins")
#
####################################################################################################
#
#   Checking and Setting Variables Complete
#
###############################################################################################################################################
# 
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
# Outputting a Dotted Line for Reporting Purposes
/bin/echo  -----------------------------------------------
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
# Outputting a Blank Line for Reporting Purposes
#/bin/echo
#
/bin/echo Ending Script '"'$ScriptName'"'
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
# Outputting a Dotted Line for Reporting Purposes
/bin/echo  -----------------------------------------------
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
# Outputting a Blank Line for Reporting Purposes
/bin/echo
SectionEnd
#
# Outputs the Current AD Allowed Admins
Echo Current AD Allowed Admins are : $CurrentLocalADAdmins
#
# Outputs a blank line for reporting purposes
echo
#
# Now Compare Current AD Allowed Admins to the Target AD Allowed Admins
if test "$CurrentLocalADAdmins" == "$TargetLocalADAdminString"
	then
		## If AD Allowed Admins Match, Nothing to do
		/bin/echo AD Allowed Admins Are Already Correct
		SectionEnd
		ScriptEnd
        exit 0
	else
		## If AD Allowed Admins Do Not Match, Change It
		/bin/echo AD Allowed Admins needs Updating
		# Outputs a blank line for reporting purposes
		/bin/echo
		# Outputs the New AD Allowed Admins
		/bin/echo AD Allowed Admins Being Reset To :
		/bin/echo $TargetLocalADAdminString
		# Outputs a blank line for reporting purposes
		/bin/echo
		dsconfigad -groups "$TargetLocalADAdminString"
		#
		SectionEnd
		ScriptEnd
		exit 0
fi
#
SectionEnd
ScriptEnd
