$in = Get-Content .\2022\Day10\input.txt

$register = 1
$cycle = 1

$signalStrengths = 0

foreach ($line in $in) {
    
    if ($cycle % 40 - 20 -eq 0) { # 20th, 60th, 100th, 140th, 180th, and 220th cycles
        $cycle * $register
        $signalStrengths += $cycle * $register
    }

    if ($line[0] -eq 'a') {
        $cycle += 1
        #Write-Host "At cycle $cycle the register is $register"
        if ($cycle % 40 - 20 -eq 0) { # 20th, 60th, 100th, 140th, 180th, and 220th cycles
            $cycle * $register
            $signalStrengths += $cycle * $register
        }
        $register += $line.Split(' ')[1]
    }

    $cycle += 1
    #Write-Host "At cycle $cycle the register is $register"
}


Write-Host "Register is $register"
Write-Host "Cycle is $cycle"
$signalStrengths