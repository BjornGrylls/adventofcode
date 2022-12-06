$in = Get-Content .\input.txt

# Ny taktik. Træk en range tjek unik er lige lang
for ($i = 0; $i -lt $in.Length; $i++) {
    $range = $in.Substring($i, 14)
    if (([char[]]$range | select -Unique).Length -eq $range.Length) {
        $i + 14
        break
    }
}