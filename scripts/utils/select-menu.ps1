function Get-SelectMenuChoice {
    param (
        [string]$Title,
        [string[]]$Options,
        [bool]$MultiSelect = $false
    )

    if ($Options.Length -le 1) {
        Write-Host "Provide at least two options to utilise select menus"
        return ,@()
    }

    Write-Host $Title
    if ($MultiSelect) { return Use-MultiSelectMenu -Options $Options } else { return Use-SelectMenu -Options $Options }
}

function Use-MultiSelectMenu {
    param (
        [string[]]$Options
    )

    Write-Host "Use UP/DOWN to move, Space to toggle, Enter to confirm.`n"

    $selected = @{}
    for ($i = 0; $i -lt $Options.Count; $i++) {
        $selected[$i] = $false
    }

    $cursorPos = 0
    $menuTop = [System.Console]::CursorTop

    :complete while ($true) {
        [System.Console]::SetCursorPosition(0, $menuTop)

        for ($i = 0; $i -lt $Options.Count; $i++) {
            $writeOptionParams = @{
                Choice = $Options[$i]
                Hovered = $i -eq $cursorPos
                Selected = $selected[$i]
                DisplayBox = $true
            }

            Write-Option @writeOptionParams
        }

        $key = [System.Console]::ReadKey($true)
        $cursorPos = Update-CursorPosition -Pos $cursorPos -Key $key -Limit $($Options.Count - 1)

        switch ($key.Key) {
            "Spacebar"  { $selected[$cursorPos] = -not $selected[$cursorPos] }
            "Enter"     { if ($selected.Values -contains $true) { break complete } }
        }
    }

    return ($selected.GetEnumerator() | Where-Object Value | ForEach-Object { $Options[$_.Key] })
}

function Use-SelectMenu {
    param (
        [string[]]$Options
    )

    Write-Host "Use UP/DOWN to move, Enter to select.`n"

    $cursorPos = 0
    $menuTop = [System.Console]::CursorTop

    :complete while ($true) {
        [System.Console]::SetCursorPosition(0, $menuTop)

        for ($i = 0; $i -lt $Options.Count; $i++) {
            Write-Option -Choice $Options[$i] -Hovered $($i -eq $cursorPos)
        }

        $key = [System.Console]::ReadKey($true)
        $cursorPos = Update-CursorPosition -Pos $cursorPos -Key $key -Limit $($Options.Count - 1)

        switch ($key.Key) {
            "Enter" { return ,@(($Options[$cursorPos])) }
        }
    }
}

function Update-CursorPosition {
    param (
        [int]$Pos,
        [ConsoleKeyInfo]$Key,
        [int]$Limit
    )

    $final = $Pos

    switch ($Key.Key) {
        "k"         { $final-- }
        "j"         { $final++ }
        "UpArrow"   { $final-- }
        "DownArrow" { $final++ }
    }

    if ($final -lt 0) { $final = $Limit }
    if ($final -gt $Limit) { $final = 0 }

    return $final
}

function Write-Option {
    param (
        [string]$Choice,
        [bool]$Hovered,
        [bool]$Selected = $false,
        [bool]$DisplayBox = $false
    )

    $prefix = if ($DisplayBox) { if ($Selected) { "[x]" } else { "[ ]" } } else { "" }
    if ($prefix -ne "") {
        $prefix += " "
    }

    if ($Hovered) {
        Write-Host " > $prefix$Choice" -ForegroundColor Cyan
    } else {
        Write-Host "   $prefix$Choice"
    }
}
