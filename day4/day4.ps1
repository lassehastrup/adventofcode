$data = Get-Content "./day4/input.txt"

function Find-XMAS {
    param (
        [string[]]$grid
    )

    $word = "XMAS"
    $wordLength = $word.Length
    $count = 0

    # Check all directions
    for ($i = 0; $i -lt $grid.Length; $i++) {
        for ($j = 0; $j -lt $grid[$i].Length; $j++) {
            # Horizontal right
            if ($j + $wordLength -le $grid[$i].Length) {
                if ($grid[$i].Substring($j, $wordLength) -eq $word) {
                    $count++
                }
            }
            # Horizontal left
            if ($j -ge $wordLength - 1) {
                if ($grid[$i].Substring($j - $wordLength + 1, $wordLength) -eq $word) {
                    $count++
                }
            }
            # Vertical down
            if ($i + $wordLength -le $grid.Length) {
                $verticalWord = ""
                for ($k = 0; $k -lt $wordLength; $k++) {
                    $verticalWord += $grid[$i + $k][$j]
                }
                if ($verticalWord -eq $word) {
                    $count++
                }
            }
            # Vertical up
            if ($i -ge $wordLength - 1) {
                $verticalWord = ""
                for ($k = 0; $k -lt $wordLength; $k++) {
                    $verticalWord += $grid[$i - $k][$j]
                }
                if ($verticalWord -eq $word) {
                    $count++
                }
            }
            # Diagonal down-right
            if ($i + $wordLength -le $grid.Length -and $j + $wordLength -le $grid[$i].Length) {
                $diagonalWord = ""
                for ($k = 0; $k -lt $wordLength; $k++) {
                    $diagonalWord += $grid[$i + $k][$j + $k]
                }
                if ($diagonalWord -eq $word) {
                    $count++
                }
            }
            # Diagonal down-left
            if ($i + $wordLength -le $grid.Length -and $j -ge $wordLength - 1) {
                $diagonalWord = ""
                for ($k = 0; $k -lt $wordLength; $k++) {
                    $diagonalWord += $grid[$i + $k][$j - $k]
                }
                if ($diagonalWord -eq $word) {
                    $count++
                }
            }
            # Diagonal up-right
            if ($i -ge $wordLength - 1 -and $j + $wordLength -le $grid[$i].Length) {
                $diagonalWord = ""
                for ($k = 0; $k -lt $wordLength; $k++) {
                    $diagonalWord += $grid[$i - $k][$j + $k]
                }
                if ($diagonalWord -eq $word) {
                    $count++
                }
            }
            # Diagonal up-left
            if ($i -ge $wordLength - 1 -and $j -ge $wordLength - 1) {
                $diagonalWord = ""
                for ($k = 0; $k -lt $wordLength; $k++) {
                    $diagonalWord += $grid[$i - $k][$j - $k]
                }
                if ($diagonalWord -eq $word) {
                    $count++
                }
            }
        }
    }

    return $count
}

$grid = $data
$result = Find-XMAS -grid $grid
Write-Output "Total XMAS found: $result"