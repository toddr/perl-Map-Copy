#!perl -T

use Test::More tests => 11;
use warnings;
use strict;

BEGIN {
    use_ok( 'Map::Copy' ) || print "Bail out!\n";
}

{ diag("cmap on a scalar");
    my $start = 'ABCD';
    my $end = cmap {tr/A-Z/a-z/} $start; 
    is( $end, 'abcd', "basic translation");
    is( $start, 'ABCD', "Original variable unmodified!");
}

{ diag("multiple translations in a single block");
    my $start = '  ABCD  ';
    my $end = cmap {tr/A-Z/a-z/; s/^\s+//; s/\s+$//} $start; 
    is( $end, 'abcd', "basic translation");
    is( $start, '  ABCD  ', "Original variable unmodified!");
}

{ diag("cmap scalar chaining");
    my $start = '  ABCD   ';
    my $end = cmap {s/^\s+//}
              cmap {s/\s+$//}
              cmap {tr/A-Z/a-z/} $start;
               
    is( $end, 'abcd', "basic translation");
    is( $start, '  ABCD   ', "Original variable unmodified!");
}

{ diag("cmap on an array");
    my @start = qw/ABCD DEFG/;
    my @end = cmap {tr/A-Z/a-z/} @start;
    ok(eq_array(\@end, [qw/abcd defg/]), "basic translation of an array");
    ok(eq_array(\@start, [qw/ABCD DEFG/]), "Original array unmodified");
}

{ diag("cmap array chaining");
    my @start = map{"  $_  "} qw/ABCD DEFG/;
    my @end = cmap {s/^\s+//}
              cmap {s/\s+$//}
              cmap {tr/A-Z/a-z/} @start;
               
    ok(eq_array(\@end, [qw/abcd defg/]), "basic translation of an array");
    ok(eq_array(\@start, [map {"  $_  "} qw/ABCD DEFG/]), "Original array unmodified");
}
