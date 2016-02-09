use Win32::GuiTest qw(FindWindowLike GetWindowText GetWindowID SetForegroundWindow SendRawKey 
SendKeys PushButton MouseClick SendMouse SendRButtonDown MouseMoveAbsPix SendMouseMoveRel WaitWindow GetWindowRect
KEYEVENTF_EXTENDEDKEY KEYEVENTF_KEYUP );


$Win32::GuiTest::debug = 0; # Set to "1" to enable verbose mode

$DEBUG=0;

my $win1, $winsub;
my @windows = FindWindowLike(0, "https.*email.kt.com"); # "^XLMAIN\$");
for (@windows) {  
  $win1=$_;
}
my ($left, $top, $right, $bottom) = GetWindowRect($win1);


if($DEBUG) { print "starting...\n"; }

for (1 .. 500){
  SetForegroundWindow($win1); sleep 1;
  ($left, $top, $right, $bottom) = GetWindowRect($win1);

#== "Actions" 버튼을 클릭한다
  SendKeys("{DOWN}"); sleep 1;
  MouseMoveAbsPix($right-50,$top+108);
  SendMouse("{LEFTCLICK}"); sleep 1;

#== 메뉴의 "Forward as Attachment" 항목을 클릭한다
  MouseMoveAbsPix($right-50,$top+210); sleep 0.3;
  MouseMoveAbsPix($right-50,$top+210); sleep 0.1;
  SendMouse("{LEFTCLICK}"); sleep 4;
  
  $winsub=WaitWindow("https.*cmd="); sleep 3;
  my ($l1, $t1, $r1, $b1) = GetWindowRect($winsub);

  MouseMoveAbsPix($l1+300,$t1+70); sleep 0.5;
  SendMouse("{LEFTCLICK}");
  MouseMoveAbsPix($l1+300,$t1+70); sleep 0.5;
  SendMouse("{LEFTCLICK}"); sleep 0.5;
  SendMouse("{LEFTCLICK}");
  SendMouseMoveRel(0,1);
  SendKeys("^v");
  sleep 0.5;

  MouseMoveAbsPix($l1+300,$t1+130); sleep 0.5;
  SendMouse("{LEFTCLICK}");
  MouseMoveAbsPix($l1+300,$t1+130); sleep 0.5;
  SendMouse("{LEFTCLICK}"); sleep 0.5;
  SendMouse("{LEFTCLICK}");
  SendMouseMoveRel(0,1);
  SendKeys("_"); sleep 0.5;

  MouseMoveAbsPix($l1+40,$t1+40); sleep 0.5;
  MouseMoveAbsPix($l1+40,$t1+40); sleep 0.5;
  if(! ($DEBUG) ) { SendMouse("{LEFTCLICK}"); }
  sleep 0.3; SendMouseMoveRel(0,1); SendMouseMoveRel(0,1); SendMouseMoveRel(0,1);
  sleep 1;

}


