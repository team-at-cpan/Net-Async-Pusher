#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);

# For more details, enable this
# use Log::Any::Adapter qw(Stdout);

use IO::Async::Loop;
use Net::Async::Pusher;

my $loop = IO::Async::Loop->new;

$loop->add(
	my $pusher = Net::Async::Pusher->new
);
say "connecting";
my $sub = $pusher->connect(
	key => 'de504dc5763aeef9ff52'
)->then(sub {
	my ($conn) = @_;
	say "have conn $conn";
	$conn->open_channel('live_trades')
})->then(sub {
	my ($ch) = @_;
	say "have ch $ch";
	$ch->subscribe(trade => sub {
		my ($ev, $data) = @_;
		say "New trade - $data";
	});
})->get;
say "Waiting for events...";
$loop->run;
$sub->()->get;

