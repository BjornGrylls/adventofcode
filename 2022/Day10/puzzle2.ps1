$in = Get-Content .\2022\Day10\input.txt

$register = 1
$cycle = 1
$CRT = 0

$executing = $false
for ($i = 0; $i -lt $in.Count; $i++) {

    # CRT drawing to terminal
    if ([Math]::Abs($CRT % 40 - $register) -le 1) {
        Write-Host -NoNewline "#"
    } else {
        Write-Host -NoNewline "."
    }
    $CRT++
    if ($cycle % 40 -eq 0) { # 20th, 60th, 100th, 140th, 180th, and 220th cycles
        Write-Host ""
    }

    if ($in[$i][0] -eq 'a') {
        if (!$executing) {
            $executing = $true
            $cycle += 1
            $i -= 1
            continue
        }       
        $executing = $false
        $register += $in[$i].Split(' ')[1]
    }

    $cycle += 1
}