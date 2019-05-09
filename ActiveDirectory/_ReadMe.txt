Run CreateUsers.ps1 to create BULK user accounts in AD.
This is useful for summer law students.

The ps1 files creates the users base on the users.csv

user.csv
FirstName: User's first name
LastName: User's last name
SamAccountName: username
AccountExpirationDate: Expiration Date
Description: [YEAR] [Season] [Type] - [Units] - [Supervisor]

	Example: 2014 Summer Law Student - Employment - SDietrich
		 2014 Fall Volunteer - IT - MBowen 
		 2014 Fellowship - Energy - TTran

HomeDirectory: User's network drive location
	\\[server]\users\[username]

	Example: \\cls1\users\skay
		 \\nplc1\users\mbowen
		 \\cclc1\users\nchhun

HomeDrive: Mapped network drive letter
ScriptPath: Login script
Path: Location in AD.  Use LADP

	Example: OU=Students,OU=Non-EmployeesCC,OU=CCLC,DC=clsphila,DC=pri
		 OU=Non-EmployeesCC,OU=CCLC,DC=clsphila,DC=pri
		 OU=Students,OU=Non-EmployeesNP,OU=NPLC,DC=clsphila,DC=pri
		 OU=Non-EmployeesNP,OU=NPLC,DC=clsphila,DC=pri

Manager: Leave blank.  

You still need to add the users to the correct members.
