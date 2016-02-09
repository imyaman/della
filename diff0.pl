use Image::Magick;

$logo=Image::Magick->New();
$logo->Read('logo:');
$sharp=Image::Magick->New();
$sharp->Read('logo:');
$sharp->Sharpen('0x1');
$difference=$logo->Compare(image=>$sharp);
print $difference;
print $difference->Get('error'), "\n";
$difference->Display();
