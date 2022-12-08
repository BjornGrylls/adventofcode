$in = Get-Content .\2022\Day8\input.txt

$visibleTrees = 0;

# Row
for ($i = 0; $i -lt $in.Count; $i++) {
    $line = [char[]]$in[$i]

    # Column
    for ($j = 0; $j -lt $line.Count; $j++) {
        
        $currentDigit = $line[$j]
        $visible = $false

        # Check up
        $y = $i - 1
        while ($y -ge 0) {
            if ($in[$y][$j] -ge $currentDigit) {
                break
            }
            $y--
        }
        if ($y -lt 0) {
            $visible = $true
        }

        # Check down
        $y = $i + 1
        while ($y -lt $in.Count) {
            if ($in[$y][$j] -ge $currentDigit) {
                break
            }
            $y++
        }
        if ($y -ge $in.Count) {
            $visible = $true
        }

        # Check left
        $x = $j - 1
        while ($x -ge 0) {
            if ($in[$i][$x] -ge $currentDigit) {
                break
            }
            $x--
        }
        if ($x -lt 0) {
            $visible = $true
        }

        # Check right
        $x = $j + 1
        while ($x -lt $line.Count) {
            if ($in[$i][$x] -ge $currentDigit) {
                break
            }
            $x++
        }
        if ($x -ge $line.Count) {
            $visible = $true
        }

        if ($visible) {
            $visibleTrees += 1
        }
    }
}

$visibleTrees