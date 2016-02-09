#!/usr/bin/env perl

use Image::Magick;

my $all = Image::Magick->new();
$all->Read('a.jpg');
my$geometry=sprintf "%dx%d+%d+%d", 70, 120, 140, 30;
my $expect = $all->Transform(crop=>$geometry);
$expect->Write("expect.jpg");
