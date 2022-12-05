$in = Get-Content .\input.txt

$elfs = @()

$currentCalories = 0
foreach ($line in $in) {
    if ($line -eq "") {
        
        $elfs += $currentCalories
        
        # Next elf
        $currentCalories = 0
    }
    $currentCalories += $line
}

$elfs | Sort-Object -Descending | Select-Object -First 3