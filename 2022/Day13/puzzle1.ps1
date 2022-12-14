$in = Get-Content .\2022\Day13\input.txt


function Compare-Packets {
    param (
        [string]$packet1,
        [string]$packet2
    )

    # Is both packets empty?
    if ($packet1.Length -eq 0 -and $packet2.Length -eq 0) { return }
    # Is packet1 empty?
    if ($packet1.Length -eq 0) {
        return $true
    }
    # Is packet2 empty?
    if ($packet2.Length -eq 0) { 
        return $false
    }

    # Are we looking at two integers?
    if ($packet1 -match "^\d+$" -and $packet2 -match "^\d+$") {
        if ([int]$packet1 -gt [int]$packet2) {
            return $false
        } elseif ([int]$packet2 -gt [int]$packet1) {
            return $true
        }

        return
    }

    # Are we looking at two lists?
    if ($packet1[0] -eq '[' -and $packet2[0] -eq '[') {
        if ($packet1.Length -ge 2) {
            $packet1 = $packet1.Substring(1, $packet1.Length - 2)
        }
        if ($packet2.Length -ge 2) {
            $packet2 = $packet2.Substring(1, $packet2.Length - 2)
        }
        
        
        # Find alting mellem klammer og erstat , med #
        $inside = 0
        for ($i = 0; $i -lt $packet1.Length; $i++) {
            switch ($packet1[$i]) {
                '[' { $inside++ }
                ']' { $inside-- }
            }
            if ($inside -gt 0) {
                if ($packet1[$i] -eq ',') {
                    $packet1 = $packet1.Remove($i, 1).Insert($i, '#')
                }
            }
        }
        for ($i = 0; $i -lt $packet2.Length; $i++) {
            switch ($packet2[$i]) {
                '[' { $inside++ }
                ']' { $inside-- }
            }
            if ($inside -gt 0) {
                if ($packet2[$i] -eq ',') {
                    $packet2 = $packet2.Remove($i, 1).Insert($i, '#')
                }
            }
        }

        # Split
        $packet1SplittetTemp = ([string]$packet1).Split(',')
        $packet2SplittetTemp = ([string]$packet2).Split(',')

        # Erstart # med , igen
        $packet1Splittet = [string[]]$packet1SplittetTemp.Replace('#', ',')
        $packet2Splittet = [string[]]$packet2SplittetTemp.Replace('#', ',')

        # Find korteste, s?? vi er f??rdige n??r korteste er tom
        $minLength = if ($packet1Splittet.Count -gt $packet2Splittet.Count) {
            $packet2Splittet.Count
        } else {
            $packet1Splittet.Count
        }

        for ($i = 0; $i -lt $minLength; $i++) {
            $res = & Compare-Packets $packet1Splittet[$i] $packet2Splittet[$i]
            switch ($res) {
                $true {
                    return $true
                }
                $false { 
                    return $false 
                }
            }
        }

        if ($packet1Splittet.Count -gt $packet2Splittet.Count) {
            return $false
        } elseif ($packet2Splittet.Count -gt $packet1Splittet.Count) {
            return $true
        } 

        return
    }

    # One int and one list
    if ($packet1 -match "^\d+$") {
        $packet1 = ([string]$packet1).Insert(0, '[')
        $packet1 += ']'

        return & Compare-Packets $packet1 $packet2
    } else {
        $packet2 = $([string]$packet2).Insert(0, '[')
        $packet2 += ']'

        return & Compare-Packets $packet1 $packet2
    }
    
}

$packetsInRightOrder = [System.Collections.ArrayList]@()
$packetIndex = 1

for ($i = 0; $i -lt $in.Count; $i += 3) { # Go to start of next packet pair
    $packet1 = $in[$i]
    $packet2 = $in[$i + 1]

    $result = & Compare-Packets $packet1 $packet2

    switch ($result) {
        $true { $packetsInRightOrder.Add($packetIndex) | Out-Null }
        $false {}
        Default { Write-Host "Failed compare result:" $result }
    }

    $packetIndex++
}

# Print result
Write-Host "Result:"
$packetsInRightOrder -join '+' | Invoke-Expression