$reports = Get-Content ./day2/input.txt

$safeCount = 0
foreach ($report in $reports) {
    $levels = $report -split '\s+' | ForEach-Object { [int]$_ }

    if ($levels.Count -lt 2) {
        continue
    }

    $isIncreasing = $true
    $isDecreasing = $true

    for ($i = 0; $i -lt $levels.Count - 1; $i++) {
        $diff = $levels[$i + 1] - $levels[$i]
        if ($diff -ge 1 -and $diff -le 3) {
            $isDecreasing = $false
        }
        elseif ($diff -le -1 -and $diff -ge -3) {
            $isIncreasing = $false
        }
        else {
            $isIncreasing = $false
            $isDecreasing = $false
            break
        }
    }

    if ($isIncreasing -or $isDecreasing) {
        $safeCount++
    }
}

Write-Output $safeCount

# Part 2

$safeCount = 0
foreach ($report in $reports) {
    $levels = $report -split '\s+' | ForEach-Object { [int]$_ }

    if ($levels.Count -lt 2) {
        continue
    }

    # Check if the sequence is already safe
    $isIncreasing = $true
    $isDecreasing = $true
    for ($i = 0; $i -lt $levels.Count - 1; $i++) {
        $diff = $levels[$i + 1] - $levels[$i]
        if ($diff -ge 1 -and $diff -le 3) {
            $isDecreasing = $false
        }
        elseif ($diff -le -1 -and $diff -ge -3) {
            $isIncreasing = $false
        }
        else {
            $isIncreasing = $false
            $isDecreasing = $false
            break
        }
    }

    if ($isIncreasing -or $isDecreasing) {
        $safeCount++
        continue
    }

    # Try removing each number once
    for ($skip = 0; $skip -lt $levels.Count; $skip++) {
        $testLevels = $levels[0..($skip-1)] + $levels[($skip+1)..($levels.Count-1)]

        $isIncreasing = $true
        $isDecreasing = $true
        for ($i = 0; $i -lt $testLevels.Count - 1; $i++) {
            $diff = $testLevels[$i + 1] - $testLevels[$i]
            if ($diff -ge 1 -and $diff -le 3) {
                $isDecreasing = $false
            }
            elseif ($diff -le -1 -and $diff -ge -3) {
                $isIncreasing = $false
            }
            else {
                $isIncreasing = $false
                $isDecreasing = $false
                break
            }
        }

        if ($isIncreasing -or $isDecreasing) {
            $safeCount++
            break
        }
    }
}

Write-Output $safeCount