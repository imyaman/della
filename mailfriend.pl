use Win32::GuiTest qw(FindWindowLike GetWindowText GetWindowID SetForegroundWindow SendRawKey 
SendKeys PushButton MouseClick SendMouse SendRButtonDown MouseMoveAbsPix SendMouseMoveRel WaitWindow GetWindowRect
KEYEVENTF_EXTENDEDKEY KEYEVENTF_KEYUP );


$Win32::GuiTest::debug = 0; # Set to "1" to enable verbose mode

$DEBUG=1;

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

# "Actions" 버튼을 클릭한다
  SendKeys("{DOWN}"); sleep 1;
  MouseMoveAbsPix($right-50,$top+108);
  SendMouse("{LEFTCLICK}"); sleep 1;

# 메뉴의 "Forward as Attachment" 항목을 클릭한다
#  SendMouseMoveRel(0,64); sleep 0.5;
  MouseMoveAbsPix($right-50,$top+210); sleep 0.5;
  MouseMoveAbsPix($right-50,$top+210); sleep 0.5;
  SendMouse("{LEFTCLICK}"); 
  
  $winsub=WaitWindow("https.*cmd=");
  my ($l1, $t1, $r1, $b1) = GetWindowRect($winsub);

  MouseMoveAbsPix($l1+300,$t1+70); sleep 0.3;
  MouseMoveAbsPix($l1+300,$t1+70); sleep 0.3;
  SendMouse("{LEFTCLICK}");
  SendMouse("{LEFTCLICK}");
  SendKeys("^v");
  SendKeys("^v");
  sleep 2;

#  sleep 1; SendKeys("{RIGHT}"); SendKeys("{RIGHT}"); sleep 2;  SendKeys("{RIGHT}"); SendMouseMoveRel(0,1); sleep 1;
#  SendKeys("+{SPACE}"); sleep 1;
#  SendKeys("imyaman\@nate.com"); sleep 0.1; SendKeys("{RIGHT}");



#  SendKeys("{TAB}"); sleep 0.3; SendKeys("{RIGHT}");
#  SendKeys("{TAB}"); sleep 0.3; SendKeys("{RIGHT}"); sleep 1;
#  SendKeys("{TAB}"); sleep 0.3; SendKeys("{RIGHT}");
#  SendKeys("{TAB}"); sleep 0.3; SendKeys("{RIGHT}");
  MouseMoveAbsPix($l1+300,$t1+105); sleep 2;
  sleep 2;
  SendKeys("_"); sleep 0.01;

  MouseMoveAbsPix($l1+40,$t1+40); sleep 0.3;
#  SendMouse("{LEFTCLICK}"); 
  sleep 0.3; SendMouseMoveRel(0,1); SendMouseMoveRel(0,1); SendMouseMoveRel(0,1);
  sleep 1;

}


