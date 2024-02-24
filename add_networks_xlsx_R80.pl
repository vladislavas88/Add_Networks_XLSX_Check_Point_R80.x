#!/usr/bin/env perl

=pod

=head1 Using the script for create networkss for Check Point R80.x mgmt_cli 
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
=cut

use strict;
use warnings;
use v5.14;
use utf8;
use Spreadsheet::Read;

#use Data::Dumper; # for debug
my $inNetworks = $ARGV[0];

# Source XLSX File with groups names
my $workbook = ReadData($inNetworks) or die "Couldn't Open file " . "$!\n";
my $sheet = $workbook->[1];
my @column = ($sheet->{cell}[1]);

# Result outFile for mgmt_cli
my $outFile = 'add_networks_R80.txt';

my %netmasks = (
    32 => '255.255.255.255',
    31 => '255.255.255.254',
    30 => '255.255.255.252',
    29 => '255.255.255.248',
    28 => '255.255.255.240',
    27 => '255.255.255.224',
    26 => '255.255.255.192',
    25 => '255.255.255.128',
    24 => '255.255.255.0',
    23 => '255.255.254.0',
    22 => '255.255.252.0',
    21 => '255.255.248.0',
    20 => '255.255.240.0',
    19 => '255.255.224.0',
    18 => '255.255.192.0',
    17 => '255.255.128.0',
    16 => '255.255.0.0',
    15 => '255.254.0.0',
    14 => '255.252.0.0',
    13 => '255.248.0.0',
    12 => '255.240.0.0',
    11 => '255.224.0.0',
    10 => '255.192.0.0',
    9  => '255.128.0.0',
    8  => '255.0.0.0',
    7  => '254.0.0.0',
    6  => '252.0.0.0',
    5  => '248.0.0.0',
    4  => '240.0.0.0',
    3  => '224.0.0.0',
    2  => '192.0.0.0',
    1  => '128.0.0.0',
    0  => '0.0.0.0',
);

my $addNetworkName = "add network name";
my $namePrefix = "gn_";
my $subnet = "subnet";
my $subnetMask = "subnet-mask";
my $version     = "--version 1.3";

# Open result outFile for writing
open( FHW, '>', $outFile ) or die "Couldn't Open file $outFile" . "$!\n";

foreach my $row (@column) {
	for (@$row) {
		$_ =~ /^((\d+)\.(\d+)\.(\d+)\.(\d+))\/(\d+)$/ if (defined);
    	my $net     = $1 if (defined);
    	my $bit     = $6 if (defined);
    	my $netmask = $netmasks{$bit} if (defined);
		say FHW "$addNetworkName" . " " . "$namePrefix" . "$net" . "_" . "$bit" . " " . "$subnet" . " " . "\"" . "$net" . "\"" . " " . "$subnetMask" . " " . "\"" . "$netmask" . "\"" . " " . "$version" if (defined);
    }
}

# Close the filehandles
close(FHW) or die "$!\n";

say "**********************************************************************************\n";
say "Networks objects TXT file: $outFile created successfully!";

my $cpUsage = <<__USAGE__;

****************************************************************************************************
* # Create the actual object
* > add network name "gn_10.1.1.0_24" subnet "10.1.1.0" subnet-mask "255.255.255.0" --version 1.3 
* > add network name "gn_10.2.2.0_25" subnet "10.2.2.0" subnet-mask "255.255.255.128" --version 1.3
* > add network name "gn_10.3.3.0_26" subnet "10.3.3.0" subnet-mask "255.255.255.192" --version 1.3
* > add network name "gn_10.4.4.0_27" subnet "10.4.4.0" subnet-mask "255.255.255.224" --version 1.3
* > add network name "gn_10.5.5.0_28" subnet "10.5.5.0" subnet-mask "255.255.255.240" --version 1.3
* > add network name "gn_10.6.6.0_29" subnet "10.6.6.0" subnet-mask "255.255.255.248" --version 1.3
* > add network name "gn_10.7.7.0_30" subnet "10.7.7.0" subnet-mask "255.255.255.252" --version 1.3
* #				
****************************************************************************************************

__USAGE__

say $cpUsage;

