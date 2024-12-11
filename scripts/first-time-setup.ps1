$glazewmConfigLocation = "$home/.glzr/glazewm/config.yaml"
$zebarAppLocation = "$home/.glzr/zebar/custom"
$zebarEnvLocation = "$zebarAppLocation/.env"


Write-Host "--- Performing further setup for glazewm"
$decision = $Host.UI.PromptForChoice('To get the intended workspace setup', 'How many monitors are expected?', @('&2', '&3'), 1)
if ($decision -eq 0) {
    $workspaceFile = "$home/.glzr/glazewm/workspaces-2-monitors.yaml"
} else {
    $workspaceFile = "$home/.glzr/glazewm/workspaces-3-monitors.yaml"
}

Write-Host "Adding "$workspaceFile" to "$glazewmConfigLocation
if ($dryrun -eq $True) {
    Write-Host "- Skipping write. Reason: Dry run enabled"
} else {
    Add-Content -Path "$home/.glzr/glazewm/config.yaml" -Value Get-Content $workspaceFile | out-null
}

Write-Host "--- Perfoming setup for zebar"
if ($dryrun -eq $False) {
    $decision = $Host.UI.PromptForChoice('To enable / disable certain modules', 'Is the device a laptop?', @('&Yes', '&No'), 0)
    if ($decision -eq 0) {
        Write-Host "-- Adding VITE_LAPTOP_MODE environment variable"
        $fileExists = Test-Path -Path $zebarEnvLocation
        if ($fileExists -eq $True) {
            Remove-Item -Path $zebarEnvLocation | out-null
        }

        New-Item -ItemType File -Path $zebarEnvLocation -Force | out-null
        Add-Content -Path $zebarEnvLocation -Value "VITE_LAPTOP_MODE=1" | out-null
    }

    Write-Host "-- Chaging directory to"$zebarLocation
    Set-Location -Value $zebarAppLocation | out-null

    npm ci
    npm run build

    Write-Host "-- Changing directory back to scripts directory"
    Set-Location -Value "$scriptDir/.." | out-null
} else {
    Write-Host "- Skipping zebar setup. Reason: Dry run enabled"
}
