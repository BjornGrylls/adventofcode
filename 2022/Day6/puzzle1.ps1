[string]$in = Get-Content .\input.txt

# Konverter bogstaver til 0-3
for ($i = 0; $i -lt $in.Length; $i++) {

    $nextEqualLetter = $in.IndexOf($in[$i], $i + 1) - $i

    if ($nextEqualLetter -gt 3 -or $nextEqualLetter -le -1) {
        $nextEqualLetter = 0
    }

    
    [char[]]$charArr = $in
    $charArr[$i] = "$nextEqualLetter"
    $in = [string]::new($charArr)

}
$in
$in.IndexOf("0000") + 4