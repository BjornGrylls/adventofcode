$in = Get-Content .\input.txt

$pairs = 0
$ofs = '-' # Til at joine intArray

foreach ($line in $in) {
    $firstElfRange = $line.Split(',')[0]
    $secondElfRange = $line.Split(',')[1]

    # Convert elf range to string
    [string]$firstElf = "-" + [string]($firstElfRange.Split('-')[0]..$firstElfRange.Split('-')[1]) + "-"
    [string]$secondElf = "-" + [string]($secondElfRange.Split('-')[0]..$secondElfRange.Split('-')[1]) + "-"

    if ($firstElf -like "*$secondElf*" -or $secondElf -like "*$firstElf*") {
        $pairs += 1
    }
}

$pairs