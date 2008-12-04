package SOAPjr::request;

use strict;
use warnings;

=head1 NAME

SOAPjr::request - the SOAPjr request object 

=head1 VERSION

Version 1.0.2

=cut

our $VERSION = "1.0.2";

=head1 SYNOPSIS

    See perldoc SOAPjr for more info.

=cut

use base qw(SOAPjr::message);
use Carp;

sub _init {
    my $self = shift;
    $self->{server} = shift;
    my $query = shift;
    $self = $self->SUPER::_init(@_);
    my $update_count = $self->set($query);
    return $self;
}

sub set {
    my $self  = shift;
    my $query = shift;
    my $count = 0;
    my $json;
    if ( $query->{params} && $query->{params}->{json} ) {
        if ($self->{json}->can("decode")) {
            # Modern-ish 2.x JSON API
            $json = $self->{json}->decode( $query->{params}->{json} );
        } elsif ($self->{json}->can("jsonToObj")) {
            # Olde Version 1.x JSON API
            $json = $self->{json}->jsonToObj( $query->{params}->{json} );
        } else {
            # TODO: handle unknown JSON API
        }
        if ( $json->{HEAD} ) {
            $self->{_data}->{HEAD} = $json->{HEAD};
        } else {
            carp "WARNING: HEAD missing";
        }
        if ( $json->{BODY} ) {
            $self->{_data}->{BODY} = $json->{BODY};
        } else {
            carp "WARNING: BODY missing";
        }
        # TODO: what about json_type
    }
    return $self->SUPER::set( $query, $count );
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

=item * SOAPjr.org 

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
