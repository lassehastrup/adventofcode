# Function to parse the input
function Parse-Input {
    param (
        [string]$inputData
    )
    $sections = $inputData -split "`n`n"
    $rules = $sections[0] -split "`n"
    $updates = $sections[1] -split "`n"
    return @($rules, $updates)
}

# Function to check if an update is in the correct order
function Is-Update-Correct {
    param (
        [array]$rules,
        [array]$update
    )
    $pageIndex = @{}
    for ($i = 0; $i -lt $update.Length; $i++) {
        $pageIndex[$update[$i]] = $i
    }
    foreach ($rule in $rules) {
        $pages = $rule -split '\|'
        $pageX = [int]$pages[0]
        $pageY = [int]$pages[1]
        if ($pageIndex.ContainsKey($pageX) -and $pageIndex.ContainsKey($pageY)) {
            if ($pageIndex[$pageX] -ge $pageIndex[$pageY]) {
                return $false
            }
        }
    }
    return $true
}

# Function to find the middle page number of an update
function Get-Middle-Page {
    param (
        [array]$update
    )
    $middleIndex = [math]::Floor($update.Length / 2)
    return $update[$middleIndex]
}

# Main script
$inputData = Get-Content -Path "./day5/input.txt" -Raw
$parsedInput = Parse-Input -inputData $inputData
$rules = $parsedInput[0]
$updates = $parsedInput[1]

$sumOfMiddlePages = 0
foreach ($update in $updates) {
    $updatePages = $update -split ',' | ForEach-Object { [int]$_ }
    if (Is-Update-Correct -rules $rules -update $updatePages) {
        $middlePage = Get-Middle-Page -update $updatePages
        $sumOfMiddlePages += $middlePage
    }
}

Write-Output $sumOfMiddlePages
