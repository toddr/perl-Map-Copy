#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Map::Copy' ) || print "Bail out!
";
}

diag( "Testing Map::Copy $Map::Copy::VERSION, Perl $], $^X" );
