$in = Get-Content .\2022\Day8\input.txt

$highestScenicScore = 0;

# Row
for ($i = 0; $i -lt $in.Count; $i++) {
    $line = [char[]]$in[$i]

    # Column
    for ($j = 0; $j -lt $line.Count; $j++) {
        
        $currentDigit = $line[$j]
        $currentScenicScore = 1

        # Check up
        $visibleTrees = 0
        $y = $i - 1
        while ($y -ge 0) {
            $visibleTrees += 1
            if ($in[$y][$j] -ge $currentDigit) {
                break
            }
            $y--
        }
        if ($visibleTrees -gt 0) {
            $currentScenicScore *= $visibleTrees
        }

        # Check down
        $visibleTrees = 0
        $y = $i + 1
        while ($y -lt $in.Count) {
            $visibleTrees += 1
            if ($in[$y][$j] -ge $currentDigit) {
                break
            }
            $y++
        }
        if ($visibleTrees -gt 0) {
            $currentScenicScore *= $visibleTrees
        }

        # Check left
        $visibleTrees = 0
        $x = $j - 1
        while ($x -ge 0) {
            $visibleTrees += 1
            if ($in[$i][$x] -ge $currentDigit) {
                break
            }
            $x--
        }
        if ($visibleTrees -gt 0) {
            $currentScenicScore *= $visibleTrees
        }

        # Check right
        $visibleTrees = 0
        $x = $j + 1
        while ($x -lt $line.Count) {
            $visibleTrees += 1
            if ($in[$i][$x] -ge $currentDigit) {
                break
            }
            $x++
        }
        if ($visibleTrees -gt 0) {
            $currentScenicScore *= $visibleTrees
        }

        if ($currentScenicScore -gt $highestScenicScore) {
            $highestScenicScore = $currentScenicScore
        }
        
    }
}

$highestScenicScore