package Net::Async::Pusher;
# ABSTRACT: use pusher.com with IO::Async
use strict;
use warnings;

our $VERSION = '0.005';
# AUTHORITY

use parent qw(IO::Async::Notifier);

=head1 NAME

Net::Async::Pusher - support for pusher.com streaming event API

=head1 SYNOPSIS

# EXAMPLE: examples/synopsis.pl

=head1 DESCRIPTION

Provides basic integration with the L<https://pusher.com|Pusher> API.

=cut

use Net::Async::Pusher::Connection;

=head2 connect

Connects to a server using a key.

 my $conn = $pusher->connect(
  key => 'abc123'
 )->get;

Resolves to a L<Net::Async::Pusher::Connection>.

=cut

sub connect {
    my ($self, %args) = @_;
    $self->add_child(
        my $conn = Net::Async::Pusher::Connection->new(
            key => $args{key} // die "need a key"
        )
    );
    $conn->connect
}

1;

__END__

=head1 AUTHOR

Tom Molesworth <TEAM@cpan.org>

=head1 LICENSE

Copyright Tom Molesworth 2015-2021. Licensed under the same terms as Perl itself.
