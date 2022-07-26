#!/usr/bin/perl

# @(#) NMG/2WM - $Id: gen_led_matrix.pl,v 1.5 2020/01/29 01:36:25 user Exp $

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

our $name_to_write='Olivia';

sub main 
{
  ($#ARGV != -1) && ($name_to_write = $ARGV[0]);
  gen_xls();
} # main

our $worksheet;
our $workbook;
our $row;
our $col;
our $format;
our $hdr_fmt;
our $tot_fmt;

### MATRIX

# char 5x5 pixels 

our %CHAR_MATRIX=(
  'A' => {
     'left' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [0, 0, 0, 0, 0],
     },
     'top' => {
       'rows' => [0, 0],
       'cols' => [1, 2],
     },
     'right' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [3, 3, 3, 3, 3],
     },
     'lower' => {
       'rows' => [3, 3],
       'cols' => [1, 2],
     },
  },
  'B' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'right' => {
      'rows' => [0, 1, 3, 4],
      'cols' => [3, 3, 3, 3],
    },
    'top' => {
      'rows' => [0, 0],
      'cols' => [1, 2],
    },
    'bottom' => {
      'rows' => [4, 4],
      'cols' => [1, 2],
    },
    'middle' => {
      'rows' => [2, 2],
      'cols' => [1, 2],
    },
  },
  'C' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'top' => {
      'rows' => [0, 0],
      'cols' => [1, 2],
    },
    'bottom' => {
      'rows' => [4, 4],
      'cols' => [1, 2],
    },
  },
  'D' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'top' => {
      'rows' => [0, 0],
      'cols' => [1, 2],
    },
    'bottom' => {
      'rows' => [4, 4],
      'cols' => [1, 2],
    },
    'right' => {
      'rows' => [1, 2, 3],
      'cols' => [3, 3, 3],
    },
  },
  'E' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'top' => {
      'rows' => [0, 0, 0],
      'cols' => [1, 2, 3],
    },
    'bottom' => {
      'rows' => [4, 4, 4],
      'cols' => [1, 2, 3],
    },
    'middle' => {
      'rows' => [2, 2],
      'cols' => [1, 2],
    },
  },
  'F' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'top' => {
      'rows' => [0, 0, 0],
      'cols' => [1, 2, 3],
    },
    'middle' => {
      'rows' => [2, 2],
      'cols' => [1, 2],
    },
  },
  'G' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'top' => {
      'rows' => [0, 0, 0],
      'cols' => [1, 2, 3],
    },
    'bottom' => {
      'rows' => [4, 4, 4],
      'cols' => [1, 2, 3],
    },
    'right' => {
      'rows' => [3],
      'cols' => [3],
    },
    'middle' => {
      'rows' => [2, 2],
      'cols' => [2, 3],
    },
  },
  'H' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'right' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [3, 3, 3, 3, 3],
    },
    'middle' => {
      'rows' => [2, 2],
      'cols' => [1, 2],
    },
  },
  'I' => {
     'top' => {
       'rows' => [0, 0, 0],
       'cols' => [0, 1, 2],
     },
     'lower' => {
       'rows' => [4, 4, 4],
       'cols' => [0, 1, 2],
     },
     'middle' => {
       'rows' => [1, 2, 3],
       'cols' => [1, 1, 1],
     },
  },
  'J' => {
     'right' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [2, 2, 2, 2, 2],
     },
     'top' => {
       'rows' => [0, 0],
       'cols' => [1, 3],
     },
     'lower' => {
       'rows' => [4, 4, 4],
       'cols' => [0, 1, 2],
     },
     'left' => {
      'rows' => [3],
      'cols' => [0],
     },
  },
  'K' => {
     'left' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [0, 0, 0, 0, 0],
     },
     'middle' => {
       'rows' => [2, 2],
       'cols' => [1, 2],
     },
     'top_leg' => {
       'rows' => [0, 1],
       'cols' => [4, 3],
     },
     'lower_leg' => {
       'rows' => [3, 4],
       'cols' => [3, 4],
     },
  },
  'L' => {
     'left' => {
       'rows' =>  [0, 1, 2, 3, 4],
       'cols' =>  [0, 0, 0, 0, 0],
     },
     'lower' => {
       'rows' =>  [4, 4],
       'cols' =>  [1, 2],
     },
  },
  'M' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'right' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [4, 4, 4, 4, 4],
    },
    'middle' => {
      'rows' => [2],
      'cols' => [2],
    },
    'middle_left' => {
      'rows' => [1],
      'cols' => [1],
    },
    'middle_right' => {
      'rows' => [1],
      'cols' => [3],
    },
  },
  'N' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'right' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [4, 4, 4, 4, 4],
    },
    'diagonal' => {
      'rows' => [1, 2, 3],
      'cols' => [1, 2, 3],
    },
  },
  'O' => {
    'upper' => {
      'rows' => [0,0,0],
      'cols' => [1,2,3],
    },
    'left' => {
      'rows' => [1,2,3],
      'cols' => [0,0,0],
    },
    'right' => {
      'rows' => [1,2,3],
      'cols' => [4,4,4],
    },
    'lower' => {
      'rows' => [4,4,4],
      'cols' => [1,2,3],
    },
  },
  'P' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'top' => {
      'rows' => [0, 0, 0],
      'cols' => [1, 2, 3],
      ,
    },
    'middle' => {
      'rows' => [2, 2, 2],
      'cols' => [1, 2, 3],
    },
    'right' => {
      'rows' => [1],
      'cols' => [3],
    },
  },
  'Q' => {
    'upper' => {
      'rows' => [0,0,0,0,0],
      'cols' => [0,1,2,3,4],
    },
    'left' => {
      'rows' => [1,2,3],
      'cols' => [0,0,0],
    },
    'right' => {
      'rows' => [1,2,3],
      'cols' => [4,4,4],
    },
    'lower' => {
      'rows' => [3,3,3],
      'cols' => [1,2,3],
    },
    'tail' => {
      'rows' => [4],
      'cols' => [2],
    },
  },
  'R' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'right' => {
      'rows' => [1, 3, 4],
      'cols' => [4, 4, 4],
    },
    'top' => {
      'rows' => [0, 0, 0],
      'cols' => [1, 2, 3],
      ,
    },
    'middle' => {
      'rows' => [2, 2, 2],
      'cols' => [1, 2, 3],
    },
  },
  'S' => {
    'top' => {
      'rows' => [0, 0, 0, 0, 0],
      'cols' => [0, 1, 2, 3, 4],
    },
    'bottom' => {
      'rows' => [4, 4, 4, 4, 4],
      'cols' => [0, 1, 2, 3, 4],
    },
    'middle' => {
      'rows' => [2, 2, 2, 2, 2],
      'cols' => [0, 1, 2, 3, 4],
    },
    'left' => {
      'rows' => [1],
      'cols' => [0],
    },
    'right' => {
      'rows' => [3],
      'cols' => [4],
    },
  },
  'T' => {
     'middle' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [2, 2, 2, 2, 2],
     },
     'top' => {
       'rows' => [0, 0, 0, 0, 0],
       'cols' => [0, 1, 2, 3, 4],
     },
  },
  'U' => {
    'left' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [0, 0, 0, 0, 0],
    },
    'right' => {
      'rows' => [0, 1, 2, 3, 4],
      'cols' => [3, 3, 3, 3, 3],
    },
    'bottom' => {
      'rows' => [4, 4],
      'cols' => [1, 2],
    },
  },
  'V' => {
     'left' => {
       'rows' => [0, 1, 2, 3],
       'cols' => [0, 0, 1, 1],
     },
     'right' => {
       'rows' => [0, 1, 2, 3],
       'cols' => [4, 4, 3, 3],
     },
     'lower' => {
       'rows' => [4],
       'cols' => [2],
     },
  },
  'W' => {
     'left' => {
       'rows' => [0, 1, 2, 3],
       'cols' => [0, 0, 0, 0],
     },
     'right' => {
       'rows' => [0, 1, 2, 3],
       'cols' => [4, 4, 4, 4],
     },
     'middle' => {
       'rows' => [2, 3],
       'cols' => [2, 2],
     },
     'lower' => {
       'rows' => [4, 4],
       'cols' => [1, 3],
     },
  },
  'X' => {
     'diagonal_1' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [0, 1, 2, 3, 4],
     },
     'diagonal_2' => {
       'rows' => [0, 1, 2, 3, 4],
       'cols' => [4, 3, 2, 1, 0],
     },
  },
  'Y' => {
     'leg' => {
       'rows' => [3, 4],
       'cols' => [2, 2],
     },
     'left' => {
       'rows' => [0, 1],
       'cols' => [0, 0],
     },
     'right' => {
       'rows' => [0, 1],
       'cols' => [4, 4],
     },
     'middle' => {
       'rows' => [2, 2],
       'cols' => [1, 3],
     },
  },
  'Z' => {
    'top' => {
      'rows' => [0, 0, 0, 0, 0],
      'cols' => [0, 1, 2, 3, 4],
    },
    'bottom' => {
      'rows' => [4, 4, 4, 4, 4],
      'cols' => [0, 1, 2, 3, 4],
    },
    'diagonal' => {
      'rows' => [1, 2, 3],
      'cols' => [3, 2, 1],
    },
  },
);

sub draw_char
{
my($ws, $row, $col, $char)=@_;
$char=uc($char);
my $last_col=$col;

if(defined $CHAR_MATRIX{$char})
  {
  my %H=%{$CHAR_MATRIX{$char}};
  foreach my $i (sort keys %H)
    {
    my %j=%{$H{$i}};
    my @rows=();
    my @cols=();
    foreach my $k (sort keys %j)
      {
      if($k eq 'rows')
        {
	@rows=@{$j{$k}};
	}
      elsif($k eq 'cols')
        {
	@cols=@{$j{$k}};
	}
      }
    # draw it
    for(my $i=0; $i <= $#cols; $i++)
      {
      my $r=$rows[$i] + $row;
      my $c=$cols[$i] + $col;
      $ws->write($r, $c, ' ', $format); 
      ($c > $last_col) && ($last_col=$c);
      }
    }
  }
# add a blank column between chars
$last_col+=2;
return($last_col);
} # draw_char


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

our $max_col = 35;

sub write_text
{
my ($txt)=@_;
$txt=uc($txt);
my @chars=split('', $txt);

$row=1;
my $last_col=1;
foreach my $char (@chars)
  {
  $last_col=draw_char($worksheet, $row, $last_col, $char);
  ($last_col >= $max_col) && last;
  }
} # write_text


sub gen_xls
{
my $wrkbk_name='led_matrix_' . $name_to_write . '.xls';
$workbook = Spreadsheet::WriteExcel->new($wrkbk_name);
add_sheet($name_to_write);
write_text($name_to_write);
$workbook->close();
} # gen_xls

main();

# Debug - check how many chars are not mapped yet 
sub check_chars
{
foreach my $k (sort keys %CHAR_MATRIX)
  {
  my %H=%{$CHAR_MATRIX{$k}};
  (!scalar(keys %H)) && print "$k\n";
  }
} # check_chars

# check_chars();
