$wingetDeps = @(
    "GlazeWM"
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
