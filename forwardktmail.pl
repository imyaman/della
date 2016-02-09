use Win32::GuiTest qw(FindWindowLike GetWindowID GetWindowRect GetWindowText 
KEYEVENTF_EXTENDEDKEY KEYEVENTF_KEYUP 
MouseClick MouseMoveAbsPix PushButton 
SendKeys SendMouse SendMouseMoveRel SendRButtonDown SendRawKey SetForegroundWindow WaitWindow);

use Imager;
use Imager::Screenshot 'screenshot';
use Image::Magick;


$Win32::GuiTest::debug = 0; # Set to "1" to enable verbose mode
$DEBUG=0;

my $win1, $winsub;
my @windows = FindWindowLike(0, "https.*email.kt.com"); # "^XLMAIN\$");
for (@windows) {  
  $win1=$_;
}
my ($left, $top, $right, $bottom) = GetWindowRect($win1);

 );



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





if($DEBUG) { print "starting...\n"; }

for (1 .. 500){
  SetForegroundWindow($win1); sleep 1;
  ($left, $top, $right, $bottom) = GetWindowRect($win1);

#== "Actions" 버튼을 클릭한다
  SendKeys("{UP}"); sleep 1;
  MouseMoveAbsPix($right-50,$top+108);
  SendMouse("{LEFTCLICK}"); sleep 1;
ot
#== 메뉴의 "Forward as Attachment" 항목을 클릭한다


}


sub forwardIt {
  MouseMoveAbsPix($right-50,$top+210); sleep 1;
  MouseMoveAbsPix($right-50,$top+210); sleep 1;
  SendMouse("{LEFTCLICK}"); sleep 4;
  
  $winsub=WaitWindow("https.*cmd="); sleep 3;
  my ($l1, $t1, $r1, $b1) = GetWindowRect($winsub);

  MouseMoveAbsPix($l1+300,$t1+70); sleep 1;
  SendMouse("{LEFTCLICK}");
  MouseMoveAbsPix($l1+300,$t1+70); sleep 1;
  SendMouse("{LEFTCLICK}"); sleep 1;
  SendMouse("{LEFTCLICK}");
  SendMouseMoveRel(0,1);
  SendKeys("^v");
  sleep 1;

  MouseMoveAbsPix($l1+300,$t1+130); sleep 1;
  SendMouse("{LEFTCLICK}");
  MouseMoveAbsPix($l1+300,$t1+130); sleep 1;
  SendMouse("{LEFTCLICK}"); sleep 1;
  SendMouse("{LEFTCLICK}");
  SendMouseMoveRel(0,1);
  SendKeys("_"); sleep 1;

  MouseMoveAbsPix($l1+40,$t1+40); sleep 1;
  MouseMoveAbsPix($l1+40,$t1+40); sleep 1;
  if(! ($DEBUG) ) { SendMouse("{LEFTCLICK}"); }
  sleep 1; SendMouseMoveRel(0,1); SendMouseMoveRel(0,1); SendMouseMoveRel(0,1);
  sleep 1;


}




