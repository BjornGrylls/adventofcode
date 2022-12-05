$scriptfile = $args[0]
if ($args[1] -notlike '') { $runs = $args[1] } else { $runs = 100 }

Write-Host "Testing Script '$scriptfile' $runs times"


$times = @()
for ($i = 1; $i -le $runs; $i++) {
    $time = (Measure-Command { & $scriptfile }).TotalMilliseconds
    $times += $time
    Write-Host "$i - $time ms"
}

$sum = 0
$times | foreach { $sum += $_ }

$avg = ($sum / $runs)

$min = $times | sort | select -First 1
$max = $times | sort -Descending | select -First 1

"min: $min"
"max: $max"
"avg: $avg"