package SOAPjr::response;

use strict;
use warnings;

=head1 NAME

SOAPjr::response - the SOAPjr response object 

=head1 VERSION

Version 1.0.0

=cut

our $VERSION = "1.0.1";

=head1 SYNOPSIS

    See perldoc SOAPjr for more info.

=cut

use base qw(SOAPjr::message);

sub _init {
    my $self = shift;
    return $self->SUPER::_init(@_);
}

sub send {
    my $self = shift;
    my $json;
    if ($self->{json}->can("encode")) {
        # Modern-ish 2.x JSON API
        $json = $self->{json}->encode( { HEAD => $self->get("HEAD"), BODY => $self->get("BODY") } );
    } elsif ($self->{json}->can("objToJson")) {
        # Olde Version 1.x JSON API
        $json = $self->{json}->objToJson( { HEAD => $self->get("HEAD"), BODY => $self->get("BODY") } );
    } else {
        # TODO: handle unknown JSON API
    }
    print $json;
    return 1;
}

=head1 AUTHOR

Rob Manson, <robman[at]cpan.org>

=head1 BUGS

Please report any bugs or feature requests to C<bug-soapjr at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=SOAPjr>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc SOAPjr


You can also look for information at:

=over 4

=item * RT: SOAPjr.org 

L<http://SOAPjr.org>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=SOAPjr>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/SOAPjr>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/SOAPjr>

=item * Search CPAN

L<http://search.cpan.org/dist/SOAPjr/>

=back

=head1 ACKNOWLEDGEMENTS

See L<http://SOAPjr.org/specs.html> for further information on related RFC's and specifications.

=head1 COPYRIGHT & LICENSE

    Copyright 2008 Rob Manson, Sean McCarthy and http://SOAPjr.org, some rights reserved.

    This file is part of SOAPjr.

    SOAPjr is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SOAPjr is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with SOAPjr.  If not, see <http://www.gnu.org/licenses/>.

=cut

1;
