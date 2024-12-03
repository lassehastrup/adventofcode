$dataInput = Import-Csv "/Users/lasse/code/personal/adventofcode/1dec/input.csv" -Delimiter ','


# part 1

$group1 = $dataInput.group1 | sort
$group2 = $dataInput.group2 | sort

$totalSum = 0
for ($i = 0; $i -lt $dataInput.Count; $i++) {
    $sum = $group1[$i] - $group2[$i]
    if ($sum -lt 0) {
        $sum = $sum * -1
    }
    $totalSum += $sum
}

# part 2

# figure out how many times numbers from group 1 exist in group 2, and vice versa
# We multiply the number of times a number from group 1 exists in group 2 with the number of times a number from group 2 exists in group 1
$totalSumGroup1 = 0

foreach ($num in $group1) {
    $match = $group2 | Where-Object { $_ -eq $num }
    if ($match) {
        $itemCount = $match.Count
        $totalSumGroup1 += [int]$itemCount * [int]$num
    }
}
