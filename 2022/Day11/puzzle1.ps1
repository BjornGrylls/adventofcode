$in = Get-Content .\2022\Day11\input.txt


# Parse input
$monkeys = @()
for ($i = 0; $i -lt $in.Count; $i += 7) { # Skip 7 to start next monkey

    $properties = [ordered]@{}

    $inspectedItems = 0
    $properties.Add('inspectedItems', $inspectedItems)

    # Starting items
    [int[]]$startingItems = [int[]]@()
    $startingItems += $in[$i + 1].Replace(' ', '').Split(':')[1].Split(',')
    $properties.Add('startingItems', $startingItems)

    
    # Operation
    $operationPart1 = $in[$i + 2].Split(' ')[-3]
    $operationArithmeticOperator = $in[$i + 2].Split(' ')[-2]
    $operationPart2 = $in[$i + 2].Split(' ')[-1]
    $properties.Add('operationPart1', $operationPart1)
    $properties.Add('operationArithmeticOperator', $operationArithmeticOperator)
    $properties.Add('operationPart2', $operationPart2)

    $Operation = {
        param ($old)
        $command = $this.operationPart1 + " " + $this.operationArithmeticOperator + " " + $this.operationPart2
        $new = $command.Replace("old", $old) | Invoke-Expression
        $this.inspectedItems += 1
        return $new
    }


    # Test
    $testDivisbleBy = $in[$i + 3].Split(' ')[-1]
    $testTrueRecipient = $in[$i + 4].Split(' ')[-1]
    $testFalseRecipient = $in[$i + 5].Split(' ')[-1]
    $properties.Add('testDivisbleBy', $testDivisbleBy)
    $properties.Add('testTrueRecipient', $testTrueRecipient)
    $properties.Add('testFalseRecipient', $testFalseRecipient)

    $Test = {
        param ($testInput)
        if ($testInput % $this.testDivisbleBy -eq 0) {
            return $this.testTrueRecipient
        } else {
            return $this.testFalseRecipient
        }
    }


    # Create monkey
    $monkey = New-Object –TypeName PSObject -Property $properties
    
    Add-Member -InputObject $monkey `
        -MemberType ScriptMethod `
        -Name 'Operation' `
        -Value $Operation

    Add-Member -InputObject $monkey `
        -MemberType ScriptMethod `
        -Name 'Test' `
        -Value $Test

    $monkeys += $monkey
}

# Run 20 rounds
for ($round = 1; $round -le 20; $round++) {
    for ($monkeyIndex = 0; $monkeyIndex -lt $monkeys.Count; $monkeyIndex++) {
        foreach ($item in $monkeys[$monkeyIndex].startingItems) {
            $inspectedWorryLevel = $monkeys[$monkeyIndex].Operation($item)
            $inspectedWorryLevel = [math]::Floor($inspectedWorryLevel / 3)
            
            $recipientIndex = $monkeys[$monkeyIndex].Test($inspectedWorryLevel)
            $monkeys[$recipientIndex].startingItems += $inspectedWorryLevel
        }
        $monkeys[$monkeyIndex].startingItems = [int[]]@() # Clean current monkeys items
    }
}

# Print result
$res = $monkeys.inspectedItems | sort -Descending | select -First 2
Write-Host "Level of monkey business is" ($res[0] * $res[1])