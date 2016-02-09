#!/usr/bin/env perl

use X11::GUITest qw/FindWindowLike 
SendKeys ClickWindow RaiseWindow WaitWindowClose GetWindowPos
WaitSeconds WaitWindowLike QuoteStringForSendKeys/;

use Image::Magick;

my $DEBUG=1;
my $w=2;
my ($win1, $winsub);
my $expectforwardable, $expectunable;
my ($x1, $y1, $width1, $height1, $borderWidth1, $screen1);
my ($x2, $y2, $width2, $height2, $borderWidth2, $screen2);
sleep 4;

my $expectforwardable=Image::Magick->new();
my $expectunableunable=Image::Magick->new();
$expectforwardable->Read("writeemail_forward.jpg");
$expectunableunable->Read("crop_1.png");

my @windows = FindWindowLike("email.kt.com/");
for (@windows) {  
  $win1=$_;
}
RaiseWindow $win1;
($x1, $y1, $width1, $height1, $borderWidth1, $screen1)=GetWindowPos($win1);

my $widthc=35; my $heightc=400; my $leftc=$width1-60; my $topc=40;
$geometry=sprintf "%dx%d+%d+%d", $widthc, $heightc, $leftc, $topc;

if($DEBUG){
  print "$x1  $y1  $width1  $height1  $win1\n";
  print "$geometry\n";
}

my $output = Image::Magick->new();
my $imgwin1 = Image::Magick->new();
my $beforec = Image::Magick->new();
my $newc;
my $difference;
my $blob=`import -window $win1 jpg:-`;

$output->BlobToImage( $blob );
my $beforec = $output->Transform(crop=>$geometry);
if($DEBUG){ unlink "import1.jpg"; $beforec->Write("import1.jpg"); }

my $compareresult;

while (1){


  $newc=Image::Magick->new();
  $blob=`import -window $win1 jpg:-`;
  $imgwin1 = Image::Magick->new();
  $imgwin1->BlobToImage( $blob );
  $newc = $imgwin1->Transform(crop=>$geometry);

  if($DEBUG) {
    unlink "output.jpg";
    $imgwin1->Write("ouptput.jpg");
    $newc->Write("newc.jpg");
    $beforec->Write("beforec.jpg");
  }

  $difference=$newc->Compare(image=>$beforec, metric=>'RMSE');
  $compareresult = $difference->Get('error');

  $beforec = $newc;
  undef $newc;

  if($compareresult == 0){
    print "same\n";
  }else{
    print "not same\n";
    myforward();
  }
  
  sleep 6;

  SendKeys "{UP}"; 

}


sub myforward {
  my ($x1, $y1, $width1, $height1, $borderWidth1, $screen1) = GetWindowPos($win1);
  if($DEBUG) { printf "\nwin1 x, y = %s, %s\n", $width1-50, 108; }
  ClickWindow $win1, $width1-50, 110; WaitSeconds $w; WaitSeconds $w;
  ClickWindow $win1, $width1-180, 204;
  WaitSeconds 2;

  undef $winsub;
  my @subwindows=WaitWindowLike("https.*NEW"); WaitSeconds 2;
  for (@subwindows){ $winsub=$_; }
  if(!($winsub)) { return 2; }

  if($DEBUG) { print "\nopening sub window $winsub\n"; }
  RaiseWindow $winsub;
  ($x2, $y2, $width2, $height2, $borderWidth2, $screen2) = GetWindowPos($winsub);
  if($DEBUG) { print "winsub width $width2, height $height2\n"; }

  $checkformresult=checkform();
  if($checkformresult==3) { return 2; }
  if($checkformresult==0){
    SendKeys "^(w)_"; WaitSeconds $w;
    WaitWindowClose($winsub);
    return 1;
  }else{
    if($DEBUG){ print "it's forwardable.\n"; }
    if($DEBUG){ printf "\nwinsub x, y = %s, %s\n", $width2-50, 108; }
    ClickWindow $winsub, $width2-100, 70; WaitSeconds $w;
    ClickWindow $winsub, $width2-100, 70; WaitSeconds $w;
    SendKeys '^(v)'; WaitSeconds $w;
    ClickWindow $winsub, $width2-100, 126; WaitSeconds $w;
    SendKeys '_'; WaitSeconds $w;
    ClickWindow $winsub, 40, 40; WaitSeconds $w;
    #SendKeys "^(w)_"; WaitSeconds $w; SendKeys "~"; WaitSeconds $w;
    WaitWindowClose($winsub);
    return 0;
  }
}

sub checkform{
  if($DEBUG) { print "checking form\n"; }
#if(RaiseWindow($winsub)==0){ return 3; }

  my $blob=`import -window $winsub png:-`;
  my $img_winsub_form=Image::Magick->new();
  if($DEBUG) { print "checking form 2\n"; }
  $img_winsub_form->BlobToImage( $blob );

  if($DEBUG) { print "checking form 3\n"; }
  my $geometry_forwardable=sprintf "%dx%d+%d+%d", 40, 80, 30, $height2-81; 
  my $imgform = $img_winsub_form->Transform(crop=>$geometry_forwardable);
  $forwardable = $imgform->Compare(image=>$expectunableunable, metric=>'RMSE');
  #if($DEBUG) { $forwardable->Display(); }
  $isforwardable = $forwardable->Get('error');
  print $isforwardable . "\n";

  if($isforwardable){
    return 0;
  }else{
    return 1;
  }
}
