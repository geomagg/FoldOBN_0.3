# 1 upcoming cmps
# 2 downgoing cmps , mirror
# 3 PS cmps
#
f77 -o multiplicidade multiplicidade.f
awk  '{ if ($1 ~ /^[:0-9:]/ ) print $1,$2}' shots.txt >shots
awk  '{ if ($1 ~ /^[:0-9:]/ ) print $1,$2}' nodes.txt >nodes
echo 1 | ./multiplicidade
rm shots 
rm nodes
