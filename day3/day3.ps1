$data = Get-Content "./day3/input.txt"
$regEx = "mul\(\d{1,3},\d{1,3}\)"

$matches = $data | Select-String -Pattern $regEx -AllMatches | ForEach-Object { $_.Matches.Value }

# multiply the numbers

$sum = 0
foreach ($match in $matches) {
    $numbers = $match -split '\D+' | Where-Object { $_ -ne '' }
    $sum += [int]$numbers[0] * [int]$numbers[1]
}

# Part 2

$doRegEx = "do\(\)"
$dontRegEx = "don't\(\)"

$matches = $data | Select-String -Pattern "$regEx|$doRegEx|$dontRegEx" -AllMatches | ForEach-Object { $_.Matches.Value }

$enabled = $true
$sum = 0
foreach ($match in $matches) {
    if ($match -match $doRegEx) {
        $enabled = $true
    }
    elseif ($match -match $dontRegEx) {
        $enabled = $false
    }
    elseif ($enabled -and $match -match $regEx) {
        $numbers = $match -split '\D+' | Where-Object { $_ -ne '' }
        $sum += [int]$numbers[0] * [int]$numbers[1]
    }
}