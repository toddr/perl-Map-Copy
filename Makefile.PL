use inc::Module::Install;

name     'Map-Copy';
all_from 'lib/Map/Copy.pm';
author   q{Todd Rinaldo <toddr@cpan.org>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

