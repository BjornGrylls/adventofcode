$in = Get-Content .\2022\Day12\input.txt

$inX = $in[0].Length
$inY = $in.Count

# Keep calm and implement dijkstra

# Parse input
$nodes = @()
for ($i = 0; $i -lt $in.Count; $i++) {
    for ($j = 0; $j -lt $in[$i].Length; $j++) {
        $nodes += [PSCustomObject]@{
            letter       = $in[$i][$j]
            letterNumber = [byte][char]$in[$i][$j]
            x            = $j
            y            = $i
            visited      = $false
            distance     = 99999 # Stort tal
        }
    }
}

($nodes | where { $_.letterNumber -eq [byte][char]'E' }).letterNumber = [byte][char]'z'
($nodes | where { $_.letterNumber -eq [byte][char]'S' }).letterNumber = [byte][char]'a'

for ($i = 0; $i -lt $nodes.Count; $i++) {
    $i
    $possibleNeighbours = @()
    if ($nodes[$i].x + 1 -lt $inX) {
        $possibleNeighbours += $nodes | where { $_.x -eq $nodes[$i].x + 1 -and $_.y -eq $nodes[$i].y }
    }
    if ($nodes[$i].x - 1 -ge 0) {
        $possibleNeighbours += $nodes | where { $_.x -eq $nodes[$i].x - 1 -and $_.y -eq $nodes[$i].y } 
    }
    if ($nodes[$i].y + 1 -lt $inY) {
        $possibleNeighbours += $nodes | where { $_.y -eq $nodes[$i].y + 1 -and $_.x -eq $nodes[$i].x } 
    }
    if ($nodes[$i].y - 1 -ge 0) {
        $possibleNeighbours += $nodes | where { $_.y -eq $nodes[$i].y - 1 -and $_.x -eq $nodes[$i].x } 
    }

    $neighbours = @()
    foreach ($neighbour in $possibleNeighbours) {
        if ($neighbour.letterNumber -le $nodes[$i].letterNumber + 1) {
            $neighbours += $neighbour
        }
       
    }

    Add-Member -InputObject $nodes[$i] `
        -NotePropertyName 'neighbours' `
        -NotePropertyValue $neighbours
}
$queue = @()

$currentNode = $nodes | where { $_.letterNumber -eq [byte][char]'a' -and $_.letter -eq 'a' }
foreach ($node in $currentNode) {
    $node.distance = 0
}
$queue += $currentNode



for ($i = 0; $i -lt $nodes.Count; $i++) {
    # Step 1 lowest vertex is dequed and saved as active
    $currentNode = $queue | sort -Property distance | select -First 1
    $tempQueue = $queue
    $queue = @()
    $queue += ($tempQueue | where { $_ -ne $currentNode })
    #$currentNode.letter

    # Step 2 Mark current node as visited
    $currentNode.visited = $true

    # Step 3 Check if current node is destination/end
    if ($currentNode.letterNumber -eq [byte][char]'z' -and $currentNode.letter -eq 'E') {
        break
    }
    
    # Step 4 Neighbours are added to queue if not visited
    foreach ($neighbour in $currentNode.neighbours) {
        if ($neighbour.visited -eq $true) {
            continue
        }

        if ($neighbour.distance -gt $currentNode.distance) {
            $neighbour.distance = $currentNode.distance + 1
        }

        $queue += $neighbour
    }
    
}

# Print result
$currentNode.distance