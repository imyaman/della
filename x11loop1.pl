#!/usr/bin/env perl

use X11::GUITest qw/FindWindowLike 
SendKeys ClickWindow RaiseWindow GetWindowPos
WaitSeconds WaitWindowLike QuoteStringForSendKeys/;

$DEBUG=1;
sleep 0.5;

my $w=1;
my $win1, $winsub;
my @windows = FindWindowLike("https.*email.kt.com");
for (@windows) {  
	$win1=$_;
}
if($win1) {print $win1; } else { die "could not find the window"}
if($DEBUG) { print "starting...\n"; }

RaiseWindow $win1;

#== click "Actions" menu

sub forward {
	my ($x1, $y1, $width1, $height1, $borderWidth1, $screen1) =
		GetWindowPos($win1);
	if($DEBUG) { printf "\nx, y = %s, %s", $width1-50, 108; }
	ClickWindow $win1, $width1-50, 108; WaitSeconds $w;
	ClickWindow $win1, $width1-50, 204;
	WaitSeconds 2;

#my $winsub=WaitWindowLike("https.*NEW"); WaitSeconds 2;
	my @subwindows=WaitWindowLike("https.*NEW"); WaitSeconds 2;
	for (@subwindows){$winsub=$_;}
	RaiseWindow $winsub;
	if($winsub) { print $winsub; } 
	if($DEBUG) { print "\nopening sub window $winsub\n"; }

	my ($x2, $y2, $width2, $height2, $borderWidth2, $screen2) = GetWindowPos($winsub);
	if($DEBUG) { printf "\nx, y = %s, %s", $width2-50, 108; }
	ClickWindow $winsub, $width2-100, 70; WaitSeconds $w;
	SendKeys '^(v)'; WaitSeconds $w;
	ClickWindow $winsub, $width2-100, 130; WaitSeconds $w;
	SendKeys '_'; WaitSeconds $w;
	ClickWindow $winsub, 40, 40; WaitSeconds $w;

}
