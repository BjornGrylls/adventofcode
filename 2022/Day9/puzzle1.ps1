$in = Get-Content .\2022\Day9\input.txt

$visitedPostitions = @()

$Hx = 0
$Hy = 0
$Tx = 0
$Ty = 0

$visitedPostitions += "$Tx $Ty"

foreach ($line in $in) {
    
    $direction = $line[0]
    $amount = $line.Split(' ')[1]

    for ($i = 0; $i -lt $amount; $i++) {
        # Move H
        switch ($direction) {
            U { $Hy += 1 }
            D { $Hy -= 1 }
            L { $Hx -= 1 }
            R { $Hx += 1 }
        }

        # Move T
        $difX = $Hx - $Tx
        $difY = $Hy - $Ty

        $movedX = $false
        $movedY = $false

        switch ($difX) {
            2 { 
                $Tx += 1
                $movedX = $true 
            }
            -2 { 
                $Tx -= 1
                $movedX = $true 
            }
        }

        switch ($difY) {
            2 { 
                $Ty += 1
                $movedY = $true
            }
            -2 { 
                $Ty -= 1
                $movedY = $true
            }
        }

        if ($movedX) {
            switch ($difY) {
                1 { $Ty += 1 }
                -1 { $Ty -= 1 }
            }
        }

        if ($movedY) {
            switch ($difX) {
                1 { $Tx += 1 }
                -1 { $Tx -= 1 }
            }
        }

        $visitedPostitions += "$Tx $Ty"
    }
}

($visitedPostitions | select -Unique).Count