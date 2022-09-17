#!/usr/bin/perl

use lib '.';

require "matrix.pl";

sub draw_char
{
my($ws, $row, $col, $char)=@_;
$char=uc($char);
my $last_col=$c;

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
    for(my $i=0; $i < $#cols; $i++)
      {
      my $r=$rows[$i] + $row;
      my $c=$cols[$i] + $col;
      $ws->write($r, $c, ' ', $format); 
      ($c > $last_col) && ($last_col=$c);
      }
    }
  }
# add a blank column between chars
$last_col++;
return($last_col);
} # draw_char
