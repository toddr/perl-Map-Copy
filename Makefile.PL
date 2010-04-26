use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Map::Copy',
    AUTHOR              => 'Todd E Rinaldo <toddr@cpan.org>',
    VERSION_FROM        => 'lib/Map/Copy.pm',
    ABSTRACT_FROM       => 'lib/Map/Copy.pm',
    PL_FILES            => {},
    ($ExtUtils::MakeMaker::VERSION >= 6.3002 ? ('LICENSE'        => 'perl', ) : ()),
    PREREQ_PM => {
        'Test::More' => 0,  # For testing
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Map-Copy-*' },
    META_MERGE  => {
        build_requires => {
            'Test::More' => 0,  # For testing
        },
        resources => {
            license => 'http://dev.perl.org/licenses/',
            homepage => 'http://wiki.github.com/toddr/perl-Map-Copy/',
#            bugtracker => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Map-Copy',
            repository => 'http://github.com/toddr/perl-Map-Copy',
#            MailingList => '',
        },
    },
);
