$in = Get-Content .\input.txt

$elfCounter = 1
$highestCalories = 0
$highestElf = 1

$currentCalories = 0
foreach ($line in $in) {
    if ($line -eq "") {
        
        if ($currentCalories -gt $highestCalories) {
            $highestCalories = $currentCalories
        }

        # Next elf
        $elfCounter += 1
        $currentCalories = 0
    }
    $currentCalories += $line
}

$highestCalories