
use Win32::GuiTest qw(FindWindowLike GetWindowText GetWindowID SetForegroundWindow SendRawKey 
SendKeys PushButton MouseClick SendMouse SendRButtonDown MouseMoveAbsPix SendMouseMoveRel WaitWindow GetWindowRect
KEYEVENTF_EXTENDEDKEY KEYEVENTF_KEYUP );

use Imager;
use Imager::Screenshot 'screenshot';

$Win32::GuiTest::debug = 0;
$DEBUG=1;

my @windows = FindWindowLike(0, "https.*email.kt.com"); # "^XLMAIN\$");
for (@windows) {  
  $win1=$_;
}
my ($left, $top, $right, $bottom) = GetWindowRect($win1);


sleep 2;

my $new, $before;
my $newc, $beforec, $tmpc;

my $leftc, $topc; my $width=35; my $height=300; $leftc=$right-$left-60; $topc=40;

$before = screenshot(hwnd => "active");
$filename="before.png";
$before->write(file=>$filename) or die $thumb->errstr;


#exit 0;
print "i got it.\n";
sleep 3;


if (-f "new.png") { 
  if (-f "before.png") { unlink "before.png"; }
  rename "new.png", "before.png";
}

$new = screenshot(hwnd => "active");
$filename="new.png";
$before->write(file=>$filename) or die $thumb->errstr;


use Image::Magick;
my $pb = new Image::Magick;
my $pn = new Image::Magick;
$pb->Read("before.png");
$pn->Read("new.png");

$geometry=sprintf "%dx%d+%d+%d", $width, $height, $leftc, $topc;
print $geometry. "\n";

$pbc = $pb->Transform(crop=>$geometry);
$pnc = $pn->Transform(crop=>$geometry);

if($DEBUG){
  unlink 'pbc.png';
  unlink 'pnc.png';
  $pbc->Write('pbc.png');
  $pnc->Write('pnc.png');
}

my $difference=$pbc->Compare(image=>$pnc, metric=>'rmse');
print $difference->Get('error'), "\n";
$difference->Display();