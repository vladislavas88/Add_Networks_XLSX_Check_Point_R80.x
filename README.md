Using the script for create networkss for Check Point R80.x mgmt_cli 
#===============================================================================
#
#       FILE: add_networks_xlsx_R80.pl
#
#       USAGE: $ sudo dnf install perl-App-cpanminus 
#		 	   $ cpanm Spreadsheet::ParseExcel Spreadsheet::XLSX Spreadsheet::Read
#		 
#		 	   $./add_networks_xlsx_R80.pl in_networks.xlsx 
#
#		$ cat ./add_networks_R80.txt
#		  add network name "gn_10.1.1.0_24" subnet "10.1.1.0" subnet-mask "255.255.255.0" --version 1.3
#		  add network name "gn_10.2.2.0_25" subnet "10.2.2.0" subnet-mask "255.255.255.128" --version 1.3
#	      add network name "gn_10.3.3.0_26" subnet "10.3.3.0" subnet-mask "255.255.255.192" --version 1.3
#	      add network name "gn_10.4.4.0_27" subnet "10.4.4.0" subnet-mask "255.255.255.224" --version 1.3
#
#  DESCRIPTION: Create network objects for Check Point dbedit
#
#      OPTIONS: ---
# REQUIREMENTS: Perl v5.14+ 
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Vladislav Sapunov 
# ORGANIZATION:
#      VERSION: 1.0.0
#      CREATED: 22.02.2024 22:48:36
#     REVISION: ---
#===============================================================================
