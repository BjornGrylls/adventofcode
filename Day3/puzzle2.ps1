$in = Get-Content .\input.txt

$sharedItems = @()

for ($i = 0; $i -lt $in.Count; $i += 3) {
    $firstElf = [char[]]$in[$i] | Sort-Object | Get-Unique
    $secondElf = [char[]]$in[$i + 1] | Sort-Object | Get-Unique
    $thirdElf = [char[]]$in[$i + 2] | Sort-Object | Get-Unique

    foreach ($letter in $firstElf) {
        if ($secondElf -clike "$letter" -and $thirdElf -clike "$letter") {
            $sharedItems += $letter
        }
    }
}

$sum = 0

foreach ($letter in $sharedItems) {
    if ([byte][char]$letter -ge 97) {
        $sum += [byte][char]$letter - 96
    } else {
        $sum += [byte][char]$letter - 38
    }
    
}

$sum
