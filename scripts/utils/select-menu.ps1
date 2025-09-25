function Get-SelectMenuChoice {
    param (
        [string]$Title,
        [string[]]$Options,
        [bool]$MultiSelect = $false
    )

    if ($Options.Length -le 1) {
        Write-LogWarning "Provide at least two options to utilise select menus"
        return ,@()
    }

    Write-Host $Title
    [System.Console]::CursorVisible = $false

    if ($MultiSelect) {
        $selected = Use-MultiSelectMenu -Options $Options
    } else {
        $selected = Use-SelectMenu -Options $Options
    }

    [System.Console]::CursorVisible = $true
    return $selected
}

function Use-MultiSelectMenu {
    param (
        [string[]]$Options
    )

    Write-Host "`nUse UP/DOWN to move, Space to toggle, Enter to confirm."

    $selected = @{}
    for ($i = 0; $i -lt $Options.Count; $i++) {
        $selected[$i] = $false
    }

    $cursorPos = 0
    $menuTop = Get-MenuTop

    # Draw initial menu
    for ($i = 0; $i -lt $Options.Count; $i++) {
        $writeOptionParams = @{
            Choice = $Options[$i]
            Hovered = $i -eq $cursorPos
            LineNumber = $menuTop + $i
            Selected = $selected[$i]
            DisplayBox = $true
        }

        Write-Option @writeOptionParams
    }

    :complete while ($true) {
        $key = [System.Console]::ReadKey($true)
        $prevCursorPos = $cursorPos
        $cursorPos = Update-CursorPosition -Pos $cursorPos -Key $key -Limit $($Options.Count - 1)

        switch ($key.Key) {
            "Spacebar"  { $selected[$cursorPos] = -not $selected[$cursorPos] }
            "Enter"     { if ($selected.Values -contains $true) { break complete } }
        }

        # Update menu after key press, only need previous and
        # current cursor positions updating

        foreach ($updatePos in @($prevCursorPos, $cursorPos)) {
            $writeOptionParams = @{
                Choice = $Options[$updatePos]
                Hovered = $updatePos -eq $cursorPos
                LineNumber = $menuTop + $updatePos
                Selected = $selected[$updatePos]
                DisplayBox = $true
            }

            Write-Option @writeOptionParams
        }

    }

    [System.Console]::SetCursorPosition(0, $menuTop + $Options.Count)
    return ($selected.GetEnumerator() | Where-Object Value | ForEach-Object { $Options[$_.Key] })
}

function Use-SelectMenu {
    param (
        [string[]]$Options
    )

    Write-Host "`nUse UP/DOWN to move, Enter to select."

    $cursorPos = 0
    $menuTop = Get-MenuTop

    # Draw initial menu
    for ($i = 0; $i -lt $Options.Count; $i++) {
        $writeOptionParams = @{
            Choice = $Options[$i]
            Hovered = $i -eq $cursorPos
            LineNumber = $menuTop + $i
        }

        Write-Option @writeOptionParams
    }


    :complete while ($true) {
        $key = [System.Console]::ReadKey($true)
        $prevCursorPos = $cursorPos
        $cursorPos = Update-CursorPosition -Pos $cursorPos -Key $key -Limit $($Options.Count - 1)

        switch ($key.Key) {
            "Enter" { break complete }
        }

        # Update menu after key press, only need previous and
        # current cursor positions updating if they are not equal

        if ($prevCursorPos -eq $cursorPos) { continue }
        foreach ($updatePos in @($prevCursorPos, $cursorPos)) {
            $writeOptionParams = @{
                Choice = $Options[$updatePos]
                Hovered = $updatePos -eq $cursorPos
                LineNumber = $menuTop + $updatePos
            }

            Write-Option @writeOptionParams
        }
    }
   
    [System.Console]::SetCursorPosition(0, $menuTop + $Options.Count)
    return ,@(($Options[$cursorPos]))
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
        [double]$LineNumber,
        [bool]$Selected = $false,
        [bool]$DisplayBox = $false
    )

    [System.Console]::SetCursorPosition(0, $LineNumber)

    $prefix = if ($DisplayBox) { if ($Selected) { "[x]" } else { "[ ]" } } else { "" }
    if ($prefix -ne "") {
        $prefix += " "
    }

    if ($Hovered) {
        $prevColour = [System.Console]::ForegroundColor
        [System.Console]::ForegroundColor = "Cyan"
        [System.Console]::Write(" > $prefix$Choice")
        [System.Console]::ForegroundColor = $prevColour
    } else {
        [System.Console]::Write("   $prefix$Choice")
    }
}

function Get-MenuTop {
    $menuTop = [System.Console]::CursorTop

    $windowHeight = [System.Console]::WindowHeight
    $maxRows = $menuTop + $Options.Count

    if ($maxRows -ge $windowHeight) {
        [System.Console]::Write("`n" * ($maxRows - $windowHeight + 1))
        $menuTop = [System.Console]::CursorTop - $Options.Count
    }

    return $menuTop
}
