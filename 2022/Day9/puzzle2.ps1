$in = Get-Content .\2022\Day9\input.txt

$visitedPostitions = @()

$ropeSegments = @(
    [PSCustomObject]@{id = 0; x = 0; y = 0 } # H
    [PSCustomObject]@{id = 1; x = 0; y = 0 }
    [PSCustomObject]@{id = 2; x = 0; y = 0 }
    [PSCustomObject]@{id = 3; x = 0; y = 0 }
    [PSCustomObject]@{id = 4; x = 0; y = 0 }
    [PSCustomObject]@{id = 5; x = 0; y = 0 }
    [PSCustomObject]@{id = 6; x = 0; y = 0 }
    [PSCustomObject]@{id = 7; x = 0; y = 0 }
    [PSCustomObject]@{id = 8; x = 0; y = 0 }
    [PSCustomObject]@{id = 9; x = 0; y = 0 }
)


$visitedPostitions += "" + $ropeSegments[9].x + " " + $ropeSegments[9].y

foreach ($line in $in) {

    $direction = $line[0]
    $amount = $line.Split(' ')[1]

    for ($i = 0; $i -lt $amount; $i++) {
        # Move H
        switch ($direction) {
            U { $ropeSegments[0].y += 1 }
            D { $ropeSegments[0].y -= 1 }
            L { $ropeSegments[0].x -= 1 }
            R { $ropeSegments[0].x += 1 }
        }

        # Move T
        for ($j = 1; $j -lt $ropeSegments.Count; $j++) {

            $difX = $ropeSegments[$j - 1].x - $ropeSegments[$j].x
            $difY = $ropeSegments[$j - 1].y - $ropeSegments[$j].y

            $movedX = $false
            $movedY = $false

            switch ($difX) {
                2 { 
                    $ropeSegments[$j].x += 1
                    $movedX = $true 
                }
                -2 { 
                    $ropeSegments[$j].x -= 1
                    $movedX = $true 
                }
            }

            switch ($difY) {
                2 { 
                    $ropeSegments[$j].y += 1
                    $movedY = $true
                }
                -2 { 
                    $ropeSegments[$j].y -= 1
                    $movedY = $true
                }
            }

            if ($movedX) {
                switch ($difY) {
                    1 { $ropeSegments[$j].y += 1 }
                    -1 { $ropeSegments[$j].y -= 1 }
                }
            }

            if ($movedY) {
                switch ($difX) {
                    1 { $ropeSegments[$j].x += 1 }
                    -1 { $ropeSegments[$j].x -= 1 }
                }
            }

        }

        $visitedPostitions += "" + $ropeSegments[9].x + " " + $ropeSegments[9].y
    }
}

($visitedPostitions | select -Unique).Count