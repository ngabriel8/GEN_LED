#!/usr/bin/perl

# @(#) NMG/2WM - $Id: gen_ledUP.pl,v 1.1.1.1 2020/01/28 05:44:48 user Exp $

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


# the letter O

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

# the letter L

$worksheet->write(1, 7, ' ', $format);
$worksheet->write(2, 7, ' ', $format);
$worksheet->write(3, 7, ' ', $format);
$worksheet->write(4, 7, ' ', $format);
$worksheet->write(5, 7, ' ', $format);
$worksheet->write(5, 8, ' ', $format);
$worksheet->write(5, 9, ' ', $format);

# skip a column
# col = 9 + 1 + 1
# the letter I

$worksheet->write(1, 11, ' ', $format);
$worksheet->write(1, 12, ' ', $format);
$worksheet->write(1, 13, ' ', $format);
$worksheet->write(2, 12, ' ', $format);
$worksheet->write(3, 12, ' ', $format);
$worksheet->write(4, 12, ' ', $format);
$worksheet->write(5, 11, ' ', $format);
$worksheet->write(5, 12, ' ', $format);
$worksheet->write(5, 13, ' ', $format);

# skip a column
# col = 13 + 1 + 1
# the letter V

# left arm

$worksheet->write(1, 15, ' ', $format);
$worksheet->write(2, 15, ' ', $format);
$worksheet->write(3, 16, ' ', $format);
$worksheet->write(4, 16, ' ', $format);

# right arm
$worksheet->write(1, 19, ' ', $format);
$worksheet->write(2, 19, ' ', $format);
$worksheet->write(3, 18, ' ', $format);
$worksheet->write(4, 18, ' ', $format);

# lower part
$worksheet->write(5, 17, ' ', $format);

# skip a column
# col = 19 + 1 + 1
# the letter I

$worksheet->write(1, 21, ' ', $format);
$worksheet->write(1, 22, ' ', $format);
$worksheet->write(1, 23, ' ', $format);
$worksheet->write(2, 22, ' ', $format);
$worksheet->write(3, 22, ' ', $format);
$worksheet->write(4, 22, ' ', $format);
$worksheet->write(5, 21, ' ', $format);
$worksheet->write(5, 22, ' ', $format);
$worksheet->write(5, 23, ' ', $format);

# skip a column
# col = 23 + 1 + 1
# the letter A

# left part

$worksheet->write(1, 25, ' ', $format);
$worksheet->write(2, 25, ' ', $format);
$worksheet->write(3, 25, ' ', $format);
$worksheet->write(4, 25, ' ', $format);
$worksheet->write(5, 25, ' ', $format);

# top part
$worksheet->write(1, 26, ' ', $format);
$worksheet->write(1, 27, ' ', $format);
$worksheet->write(1, 28, ' ', $format);

#  right part
$worksheet->write(1, 29, ' ', $format);
$worksheet->write(2, 29, ' ', $format);
$worksheet->write(3, 29, ' ', $format);
$worksheet->write(4, 29, ' ', $format);
$worksheet->write(5, 29, ' ', $format);

# before last row part
$worksheet->write(4, 26, ' ', $format);
$worksheet->write(4, 27, ' ', $format);
$worksheet->write(4, 28, ' ', $format);


} # write_text

sub gen_xls
{
my $wrkbk_name='ledUP.xls';
$workbook = Spreadsheet::WriteExcel->new($wrkbk_name);
add_sheet('LED');
write_text();

$workbook->close();
} # gen_xls

main();
