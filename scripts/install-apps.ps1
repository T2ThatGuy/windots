$wingetDeps = @(
    "GlazeWM"
)

$scoopDeps = @(
    "neovim"
    "fastfetch"
    "fzf"
    "eza"
    "zoxide"
    "wezterm"
    "Flow-Launcher"
)

$scoopBuckets = @(
    "extras" # <--  WezTerm
)

Write-Host "--- Installing missing dependencies (Winget)"
$installedWingetDeps = winget list | Out-String
foreach ($wingetDep in $wingetDeps) {
    if ($installedWingetDeps -match $wingetDep) {
        continue
    }

    if ($dryrun -eq $true) {
        Write-Host "- Skipping install of $wingetDep. Reason: Dry run enabled"
        continue
    }

    winget install $wingetDep
}

Write-Host "--- Installing missing dependencies (Scoop)"
Write-Host "-- Adding missing buckets"
$installedScoopBuckets = scoop bucket list
foreach ($scoopBucket in $scoopBuckets) {
    if ($installedScoopBuckets -match $scoopBucket) {
        continue
    }

    if ($dryrun -eq $true) {
        Write-Host "- Skipping install of $scoopBucket. Reason: Dry run enabled"
        continue
    }

    scoop bucket add $scoopBucket
}

$installedScoopDeps = scoop list
foreach ($scoopDep in $scoopDeps) {
    if ($installedScoopDeps -match $scoopDep) {
        continue
    }

    if ($dryrun -eq $true) {
        Write-Host "- Skipping install of $scoopDep. Reason: Dry run enabled"
        continue
    }

    scoop install $scoopDep
}
