$in = Get-Content .\input.txt

$indexStacks = 0

for ($i = 0; $i -lt $in.Count; $i++) {
    if ($in[$i].Trim()[0] -eq "1") {
        $indexStacks = $i
    } 
}


$stacks = $in[$indexStacks].Replace("  ", " ").Replace("  ", " ").Trim().Split(" ")

# Populate stacks
for ($j = 0; $j -lt $stacks.Count; $j++) {
    $stackI = $in[$indexStacks].IndexOf($stacks[$j][0])

    for ($i = $indexStacks - 1; $i -ge 0; $i--) {
        $currentBox = $in[$i][$stackI]
        if ($currentBox -ne " ") {
            $stacks[$j] += $currentBox
        }
        
    }
}

$stacks = , "0" + $stacks


# Flyt kasser
for ($i = $indexStacks + 2; $i -lt $in.Count; $i++) {
    $move = $in[$i].Split(" ")[1]
    $from = $in[$i].Split(" ")[3]
    $to = $in[$i].Split(" ")[5]

    for ($j = 0; $j -lt $move; $j++) {
        # Fjern sidste
        $last = $stacks[$from][$stacks[$from].Length - 1]
        $stacks[$from] = $stacks[$from].Substring(0, $stacks[$from].Length - 1)
 
        #Tilføj til ny stack
        $stacks[$to] += $last
    }

}

$res = "";
foreach ($stack in $stacks) {
    $res += $stack[$stack.Length - 1]
}
$res.Substring(1, $res.Length-1)