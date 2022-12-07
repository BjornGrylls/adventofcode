$in = Get-Content .\input.txt

$folders = @{}

$currentFolderSize = 0
# Udregn direkte indhold af foldere 
for ($i = $in.Length - 1; $i -ge 0; $i--) {

    $currentFile = $in[$i].Split(' ')[0]

    if ($currentFile -match '^\d+$') { # Is it a number?
        $currentFolderSize += $currentFile
    } elseif ($in[$i] -eq "$ ls") {
        $folderNameOld = $in[$i - 1].Split(' ')[2]
        $folderNameNew = [guid]::NewGuid().Guid

        # Replace old folder name with new one
        $in[$i - 1] = "$ cd $folderNameNew"
        for ($j = $i; $j -ge $0; $j--) {
            if ($in[$j] -eq "dir $folderNameOld") {
                $in[$j] = "dir $folderNameNew"
                break
            }
        }
        
        $key = $folderNameNew
        $value = $currentFolderSize
        $folders.Add( $key, $value )

        $currentFolderSize = 0
    }
}

$folders.Keys

$currentFolderSize = 0
# Udregn indirekte indhold af foldere 
for ($i = $in.Length - 1; $i -ge 0; $i--) {

    $currentFile = $in[$i].Split(' ')[0]

    if ($currentFile -eq "dir") {
        $currentFolderSize += $folders[$in[$i].Split(' ')[1]]
    } elseif ($in[$i] -eq "$ ls") {
        $folders[$in[$i - 1].Split(' ')[2]] += $currentFolderSize
        $folders.Get_Item($in[$i - 1].Split(' ')[2])
        $currentFolderSize = 0
    }
    
}

$folders

# Find foldere mindre end 100.000
$folders.Values | where { $_ -lt 100000 } | Measure-Object -Sum