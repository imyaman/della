#!/usr/bin/env perl

use X11::GUITest qw/StartApp WaitWindowViewable FindWindowLike SendKeys/;

my $win = FindWindowLike('https');
print $win;
