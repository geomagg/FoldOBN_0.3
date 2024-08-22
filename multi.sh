awk  '{ if ($1 ~ /^[:0-9:]/ ) print $1,$2}' shots.txt >shots
awk  '{ if ($1 ~ /^[:0-9:]/ ) print $1,$2}' nodes.txt >nodes
./multiplicidade
