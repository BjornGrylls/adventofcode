$in = Get-Content .\input.txt

$pairs = 0
$ofs = '-' # Til at joine intArray

foreach ($line in $in) {
    $firstElfRange = $line.Split(',')[0]
    $secondElfRange = $line.Split(',')[1]

    # Convert elf range to array
    $firstElfArr = ($firstElfRange.Split('-')[0]..$firstElfRange.Split('-')[1])
    $secondElfArr = ($secondElfRange.Split('-')[0]..$secondElfRange.Split('-')[1])

    # Convert elf array to string
    [string]$firstElf = "-" + [string]$firstElfArr + "-"
    [string]$secondElf = "-" + [string]$secondElfArr + "-"

    foreach ($number in $firstElfArr) {
        if ($secondElf -like "*-" + $number + "-*") {
            $pairs += 1
            break
        }
    }
}

$pairs # 537 er for højt