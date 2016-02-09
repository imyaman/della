#!/usr/bin/env perl

use X11::GUITest qw/FindWindowLike 
SendKeys ClickWindow RaiseWindow GetWindowPos
WaitSeconds WaitWindowLike QuoteStringForSendKeys/;

use Image::Magick;

my $DEBUG=1;

my @windows = FindWindowLike("email.kt.com/ -");
for (@windows) {  
  $win1=$_;
}
RaiseWindow $win1;
my ($x1, $y1, $width1, $height1, $borderWidth1, $screen1)=GetWindowPos($win1);

my $widthc=35;
my $heightc=300; 
my $leftc=$width1-60; 
my $topc=40;
$geometry=sprintf "%dx%d+%d+%d", $widthc, $heightc, $leftc, $topc;

if($DEBUG){
  print "$x1  $y1  $width1  $height1  $win1\n";
  print "$geometry\n";
}

my $blob=`import -window $win1 jpg:-`;
my $output = Image::Magick->new();
my $beforec = Image::Magick->new();
my $newc;
my $difference;

$output->BlobToImage( $blob );
my $beforec = $output->Transform(crop=>$geometry);
if($DEBUG){ unlink "import1.jpg"; $beforec->Write("import1.jpg"); }

my $compareresult;

for (1 .. 32){

  $newc=Image::Magick->new();
  $blob=`import -window $win1 jpg:-`;
  $output = Image::Magick->new();
  $output->BlobToImage( $blob );
  $newc = $output->Transform(crop=>$geometry);

  if($DEBUG) {
    unlink "output.jpg";
    $output->Write("ouptput.jpg");
    $newc->Write("newc.jpg");
    $beforec->Write("beforec.jpg");
  }

  $difference=$newc->Compare(image=>$beforec, metric=>'RMSE');
  $compareresult = $difference->Get('error');
  if($compareresult == 0){
    print "same\n";
  }else{
    print "not same\n";
  }

  $beforec = $newc;
  undef $newc;
  
  SendKeys "{}"; 
  sleep 4;

}


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



