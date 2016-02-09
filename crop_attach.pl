#!/usr/bin/env perl

use X11::GUITest qw/FindWindowLike 
SendKeys ClickWindow RaiseWindow WaitWindowClose GetWindowPos
WaitSeconds WaitWindowLike QuoteStringForSendKeys/;
use Image::Magick;

my ($x2, $y2, $width2, $height2, $borderWidth2, $screen2);
my $all = Image::Magick->new();

my @subwindows=FindWindowLike("https.*NEW"); WaitSeconds 2;
for (@subwindows){$winsub=$_;}
if($winsub) {
  if($DEBUG) { print "\nopening sub window $winsub\n"; }
  RaiseWindow $winsub;
} else {
  return 2;
}

($x2, $y2, $width2, $height2, $borderWidth2, $screen2) = GetWindowPos($winsub);

my $blob=`import -window $winsub png:-`;
my $img_winsub_form=Image::Magick->new();
$img_winsub_form->BlobToImage( $blob );
#$img_winsub_form->Display();

my $geometry_forwardable=sprintf "%dx%d+%d+%d", 40, 80, 30, $height2-81; 
my $imgform = $img_winsub_form->Transform(crop=>$geometry_forwardable);
$imgform->Write("crop_1.png");
$imgform->Display();
#$forwardable = $imgform->Compare(image=>$expectunableunable, metric=>'RMSE');
#print $forwardable . "\n";

exit 1;
