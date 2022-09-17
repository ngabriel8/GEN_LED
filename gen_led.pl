#!/usr/bin/perl

# @(#) NMG/2WM - $Id: gen_led.pl,v 1.1.1.1 2020/01/28 05:44:48 user Exp $

use strict;
use warnings;


use File::Basename qw(basename);

use Spreadsheet::WriteExcel;
use Data::Dumper;


  # 'Formats'  => {
     # 'format'  => { align => 'center', bold => 1, color => 'blue', },
     # 'hdr_fmt' => { align => 'center', bold => 1, color => 'blue', bg_color => 'silver', border => 1,},
     # 'tot_fmt' => { align => 'center', bold => 1, color => 'blue', bg_color => 'yellow', border => 1,
                    # center_across => 1, valign  => 'center',},
  # },



my $bname=basename($0, '.pl');


sub main 
{
  gen_xls();
} # main

our $worksheet;
our $workbook;
our $row;
our $col;
our $format;
our $hdr_fmt;
our $tot_fmt;

sub add_sheet
{
my($tag)=@_;
my $sheet_name = ucfirst($tag);
$worksheet = $workbook->add_worksheet($sheet_name);

# Rows = 8 , columns = 35

my $color='black';

$format = $workbook->add_format(
                                                bg_color => $color,
                                                pattern  => 1,
                                                border   => 1
                                             );

$row=0;
$col=0;
for(; $col < 35; $col++)
  {
  $worksheet->set_column($col, 1, 2);
  }
} # add_sheet

# char 5x5 pixels 

our $char_w=5;
our $char_h=5;

sub write_text
{
my $begin=2;
my $climit=$begin + $char_w;
my $rlimit=$begin + $char_h;


# the letter O - upper case

# upper part
$worksheet->write(1, 2, ' ', $format); 
$worksheet->write(1, 3, ' ', $format);
$worksheet->write(1, 4, ' ', $format);

# left part
$worksheet->write(2, 1, ' ', $format);
$worksheet->write(3, 1, ' ', $format);
$worksheet->write(4, 1, ' ', $format);

# right part
$worksheet->write(2, 5, ' ', $format);
$worksheet->write(3, 5, ' ', $format);
$worksheet->write(4, 5, ' ', $format);

# lower part
$worksheet->write(5, 2, ' ', $format);
$worksheet->write(5, 3, ' ', $format);
$worksheet->write(5, 4, ' ', $format);



# skip a column
# col = 5 + 1 + 1

# the letter L  - lower case

# left part
$worksheet->write(1, 7, ' ', $format);
$worksheet->write(2, 7, ' ', $format);
$worksheet->write(3, 7, ' ', $format);
$worksheet->write(4, 7, ' ', $format);
$worksheet->write(5, 7, ' ', $format);

# skip a column
# col = 7 + 1 + 1
# the letter i - lower case

$worksheet->write(1, 9, ' ', $format);
$worksheet->write(3, 9, ' ', $format);
$worksheet->write(4, 9, ' ', $format);
$worksheet->write(5, 9, ' ', $format);

# skip a column
# col = 9 + 1 + 1
# the letter v - lower case

# left arm

$worksheet->write(2, 11, ' ', $format);
$worksheet->write(3, 11, ' ', $format);
$worksheet->write(4, 11, ' ', $format);

$worksheet->write(5, 12, ' ', $format);

# right arm
$worksheet->write(2, 13, ' ', $format);
$worksheet->write(3, 13, ' ', $format);
$worksheet->write(4, 13, ' ', $format);

# skip a column
# col = 13 + 1 + 1
# the letter i - lower case

$worksheet->write(1, 15, ' ', $format);
$worksheet->write(3, 15, ' ', $format);
$worksheet->write(4, 15, ' ', $format);
$worksheet->write(5, 15, ' ', $format);

# skip a column
# col = 15 + 1 + 1
# the letter a - lower case


# left part

$worksheet->write(1, 17, ' ', $format);
$worksheet->write(1, 18, ' ', $format);
# $worksheet->write(1, 19, ' ', $format);
$worksheet->write(3, 17, ' ', $format);
$worksheet->write(3, 18, ' ', $format);
# $worksheet->write(3, 19, ' ', $format);

$worksheet->write(4, 17, ' ', $format);

$worksheet->write(5, 17, ' ', $format);
$worksheet->write(5, 18, ' ', $format);
# $worksheet->write(5, 19, ' ', $format);

#  right part
$worksheet->write(1, 19, ' ', $format);
$worksheet->write(2, 19, ' ', $format);
$worksheet->write(3, 19, ' ', $format);
$worksheet->write(4, 19, ' ', $format);
$worksheet->write(5, 19, ' ', $format);

$worksheet->write(5, 20, ' ', $format);



} # write_text

sub gen_xls
{
my $wrkbk_name='led.xls';
$workbook = Spreadsheet::WriteExcel->new($wrkbk_name);
add_sheet('LED');
write_text();

$workbook->close();
} # gen_xls

main();
