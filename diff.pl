use Image::Magick;
my $pb = new Image::Magick;
my $pn = new Image::Magick;
$pb->Read("beforec.jpg");
$pn->Read("newc.jpg");

$geometry=sprintf "%dx%d+%d+%d", 5, 5, 2, 2;
print $geometry. "\n";

$pbc = $pb->Transform(crop=>$geometry);
$pnc = $pn->Transform(crop=>$geometry);

my $difference=$pbc->Compare(image=>$pnc, metric=>'rmse');
print $difference->Get('error'), "\n";
$difference->Display();
