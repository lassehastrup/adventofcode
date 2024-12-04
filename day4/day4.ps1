function Count-Xmas {
    param (
        [string[]]$grid
    )

    # Define the word to search for and its length
    $word = "XMAS"
    $wordLen = $word.Length

    # Define all possible directions to search for the word
    $directions = @(
        @(0, 1),  # right
        @(1, 0),  # down
        @(1, 1),  # down-right
        @(1, -1), # down-left
        @(0, -1), # left
        @(-1, 0), # up
        @(-1, -1),# up-left
        @(-1, 1)  # up-right
    )

    # Check if a position is within the grid boundaries
    function Is-Valid {
        param (
            [int]$x,
            [int]$y,
            [string[]]$grid
        )
        return $x -ge 0 -and $x -lt $grid.Length -and $y -ge 0 -and $y -lt $grid[0].Length
    }

    # Search for the word starting from a given position in a specific direction
    function Search-From {
        param (
            [int]$x,
            [int]$y,
            [int]$dx,
            [int]$dy,
            [string[]]$grid,
            [string]$word,
            [int]$wordLen
        )
        for ($i = 0; $i -lt $wordLen; $i++) {
            $nx = $x + $i * $dx
            $ny = $y + $i * $dy
            if (-not (Is-Valid -x $nx -y $ny -grid $grid) -or $grid[$nx][$ny] -ne $word[$i]) {
                return $false
            }
        }
        return $true
    }

    $count = 0
    # Iterate over each cell in the grid
    for ($i = 0; $i -lt $grid.Length; $i++) {
        for ($j = 0; $j -lt $grid[0].Length; $j++) {
            # Check all directions from the current cell
            foreach ($direction in $directions) {
                if (Search-From -x $i -y $j -dx $direction[0] -dy $direction[1] -grid $grid -word $word -wordLen $wordLen) {
                    $count++
                }
            }
        }
    }

    return $count
}

# Read grid from input.txt
$grid = Get-Content -Path "input.txt"

# Print the count of occurrences of the word "XMAS"
Write-Output (Count-Xmas -grid $grid)