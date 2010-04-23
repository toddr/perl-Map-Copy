package Map::Copy;

=head1 NAME

Map::Copy - The great new Map::Copy!

=head1 VERSION

Version 0.001_001

=cut


use vars qw(@EXPORT @EXPORT_OK $VERSION @ISA);

BEGIN {
    require Exporter;
    @ISA = qw(Exporter);
}

our $VERSION = '0.001_001';

$VERSION = eval $VERSION;

@EXPORT = @EXPORT_OK = qw(cmap);


=head1 SYNOPSIS

Often you want to make a copy of a variable and clean it up. You'd typically write this:

    my $result = $start;
    $result =~ tr/A-Z/a-z/;
    $result =~ s/^\s+//;
    $result =~ s/\s+$//;

Another alternative that's a little eviler

    my $result;
    for($result = $start) {
        tr/A-Z/a-z/;
        s/^\s+//;
        s/\s+$//;
    }     

Map won't work since it alters $_ in place. Map is also going to force you to have parentesis to force an array.
Enter Map::Copy: 

    my $result = cmap {tr/A-Z/a-z/}
                 cmap {s/^\s+//}
                 cmap {s/\s+$//} $start;

    or

    my $result = cmap {tr/A-Z/a-z/; s/^\s+//; s/\s+$//} $start;
                      
=head1 EXPORT

cmap will be available anywhere you use this module.

WARNING: I reserve the right to change the name of cmap. This is an experimental 

=head1 SUBROUTINES/METHODS

=head2 cmap

=cut

sub cmap (&@) {
    my ($block, @copy) = @_;

    my $wantarray = wantarray;
     
    () = map {$block->($_)} @copy;

    return $copy[0] if(@copy == 1);    
    return @copy;
    return $wantarray ? @copy : $copy[0];
}

=head1 AUTHOR

Todd Rinaldo, C<< <toddr at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-map-copy at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Map-Copy>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Map::Copy


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Map-Copy>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Map-Copy>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Map-Copy>

=item * Search CPAN

L<http://search.cpan.org/dist/Map-Copy/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Todd Rinaldo.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Map::Copy
