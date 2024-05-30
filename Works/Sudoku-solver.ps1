function IsValid ($board, $row, $col, $num) {
    for ($d = 0; $d -lt 9; $d++) {
        if ($board[$row][$d] -eq $num) { return $false }
        if ($board[$d][$col] -eq $num) { return $false }
        if ($board[(3 * [Math]::Floor($row / 3)) + [Math]::Floor($d / 3)][(3 * [Math]::Floor($col / 3)) + $d % 3] -eq $num) { return $false }
    }
    return $true
}

function Solve-Sudoku ($board, $row = 0, $col = 0) {
    if ($row -eq 9) { return $true }
    if ($col -eq 9) { return Solve-Sudoku $board ($row + 1) 0 }
    if ($board[$row][$col] -ne 0) { return Solve-Sudoku $board $row ($col + 1) }

    for ($num = 1; $num -le 9; $num++) {
        if (IsValid $board $row $col $num) {
            $board[$row][$col] = $num
            if (Solve-Sudoku $board $row ($col + 1)) { return $true }
            $board[$row][$col] = 0
        }
    }
    return $false
}

# Beispiel für ein Sudoku-Brett
$board = @(
    @(5, 3, 0, 0, 7, 0, 0, 0, 0),
    @(6, 0, 0, 1, 9, 5, 0, 0, 0),
    @(0, 9, 8, 0, 0, 0, 0, 6, 0),
    @(8, 0, 0, 0, 6, 0, 0, 0, 3),
    @(4, 0, 0, 8, 0, 3, 0, 0, 1),
    @(7, 0, 0, 0, 2, 0, 0, 0, 6),
    @(0, 6, 0, 0, 0, 0, 2, 8, 0),
    @(0, 0, 0, 4, 1, 9, 0, 0, 5),
    @(0, 0, 0, 0, 8, 0, 0, 7, 9)
)

if (Solve-Sudoku $board) {
  $board | ForEach-Object { $_ -join ' ' }
} else {
    Write-Host "Keine Lösung gefunden"
}
