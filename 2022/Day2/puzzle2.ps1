$in = Get-Content .\input.txt

$in = $in.Replace('A', 1) # Rock
$in = $in.Replace('B', 2) # Paper
$in = $in.Replace('C', 3) # Scissor
$in = $in.Replace('X', 1) # Lose
$in = $in.Replace('Y', 2) # Draw
$in = $in.Replace('Z', 3) # Win

$scores = @()


foreach ($line in $in) {
    $scores += [PSCustomObject]@{
        opponent = $line.Split()[0]
        response = $line.Split()[1]
    }
}

$totalScore = 0
Write-Host " "
    
foreach ($score in $scores) {
    $currentScore = 0
    switch ($score.response) {
        1 {
            $currentScore += 0
            switch ($score.opponent) {
                1 { $currentScore += 3 }
                2 { $currentScore += 1 }
                3 { $currentScore += 2 }
            }
        }
        2 { 
            $currentScore += 3
            switch ($score.opponent) {
                1 { $currentScore += 1 }
                2 { $currentScore += 2 }
                3 { $currentScore += 3 }
            }
        }
        3 {
            $currentScore += 6
            switch ($score.opponent) {
                1 { $currentScore += 2 }
                2 { $currentScore += 3 }
                3 { $currentScore += 1 }
            }
        }
    }

    $totalScore += $currentScore
}

$totalScore