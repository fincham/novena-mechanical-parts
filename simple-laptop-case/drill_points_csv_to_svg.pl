#!/usr/bin/perl

$x_min = 22.000;
$x_max = 324.580;
$y_min = 20.725;
$y_max = 217.460;
$x_max_page = $x_max + $x_min;
$y_max_page = $y_max + $y_min;

$fill{novena} = "#cc0000";
$fill{senoko} = "#00cc00";
$fill{hd} = "#0000cc";
$fill{peek} = "#00cccc";
$fill{peek_fp} = "#cccc00";
$fill{peek_batt} = "#cc00cc";

print <<HEADER;
<?xml version="1.0"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="${x_max_page}mm" height="${y_max_page}mm" viewBox="0 0 $x_max_page $y_max_page" xmlns="http://www.w3.org/2000/svg" version="1.1">
HEADER


while(<>) {
  y/\r\n//d;
  ($r,$x,$y,$part) = split /,/;
  $d = 2* $r;
  next if $part eq "part";
  if ($part ne $last_part) {
    $last_part = $part;
    $item_index = 0;
    if ($part_index++) {
      print qq(</g>\n);
    }
    print qq(<g id="$part" transform="translate(0,${y_max_page}) scale(1,-1)">\n);
    print qq(<title>$part</title>\n);
  }
  $item_index++;
  print qq(<path id="${part}_${item_index}" d="M $x $y l 0 $r a $r $r 0 0 0 $r -$r l -$d 0 a $r $r 0 0 1 $r -$r l 0 $r 0 Z" stroke="#000000" stroke-width="0mm" style="fill:$fill{$part}" />\n);
}
print qq(</g>\n);

print <<FOOTER;
</svg>
FOOTER
