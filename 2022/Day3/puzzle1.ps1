$in = Get-Content .\input.txt

$sharedItems = @()

foreach ($line in $in) {
    $firstHalf = [char[]]$line.Substring(0, $line.Length / 2) | Sort-Object | Get-Unique
    $secondHalf = [char[]]$line.Substring($line.Length / 2, $line.Length / 2) | Sort-Object | Get-Unique

    foreach ($letter in $firstHalf) {
        $sharedItems += $secondHalf -clike "$letter"
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
