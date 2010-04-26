#!perl -T

use Test::More tests => 22;
use warnings;
use strict;

BEGIN {
    use_ok( 'Map::Copy' ) || print "Bail out!\n";
}

{ pass(" -- cpmap on a scalar");
    my $start = 'ABCD';
    my $end = cpmap {tr/A-Z/a-z/} $start; 
    is( $end, 'abcd', "basic translation");
    is( $start, 'ABCD', "Original variable unmodified!");
}

{ pass(" -- multiple translations in a single block");
    my $start = '  ABCD  ';
    my $end = cpmap {tr/A-Z/a-z/; s/^\s+//; s/\s+$//} $start; 
    is( $end, 'abcd', "basic translation");
    is( $start, '  ABCD  ', "Original variable unmodified!");
}

{ pass(" -- cpmap scalar chaining");
    my $start = '  ABCD   ';
    my $end = cpmap {s/^\s+//}
              cpmap {s/\s+$//}
              cpmap {tr/A-Z/a-z/} $start;
               
    is( $end, 'abcd', "basic translation");
    is( $start, '  ABCD   ', "Original variable unmodified!");
}

{ pass(" -- cpmap on an array");
    my @start = qw/ABCD DEFG/;
    my @end = cpmap {tr/A-Z/a-z/} @start;
    is_deeply(\@end, [qw/abcd defg/], "basic translation of an array");
    is_deeply(\@start, [qw/ABCD DEFG/], "Original array unmodified");
}

{ pass(" -- cpmap on an array explicitly requesting a scalar return");
    my @start = qw/ABCD DEFG/;
    my @end = scalar cpmap {tr/A-Z/a-z/} @start;
    is_deeply(\@end, [qw/abcd/], "basic translation of an array");
    is_deeply(\@start, [qw/ABCD DEFG/], "Original array unmodified");
}

{ pass(" -- cpmap array chaining");
    my @start = map{"  $_  "} qw/ABCD DEFG/;
    my @end = cpmap {s/^\s+//}
              cpmap {s/\s+$//}
              cpmap {tr/A-Z/a-z/} @start;
               
    is_deeply(\@end, [qw/abcd defg/], "basic translation of an array");
    is_deeply(\@start, [map {"  $_  "} qw/ABCD DEFG/], "Original array unmodified");
}

{ pass(" -- cpmap array chaining with only 1 return item.");
    my @start = map{"  $_  "} qw/ABCD/;
    my @end = cpmap {s/^\s+//}
              cpmap {s/\s+$//}
              cpmap {tr/A-Z/a-z/} @start;
               
    is_deeply(\@end, [qw/abcd/], "basic translation of an array");
    is_deeply(\@start, [map {"  $_  "} qw/ABCD/], "Original array unmodified");
}
