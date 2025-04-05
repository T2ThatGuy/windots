
# Ask if this run should be a dry run or not (default Yes)
$decision = $Host.UI.PromptForChoice('', 'Perform dryrun?', @('&Yes', '&No'), 0)
if ($decision -eq 0) {
    $dryrun = $true
} else {
    $dryrun = $false
}

$scriptDir = "$PSscriptRoot\scripts"
& "$scriptDir/install-apps.ps1"
& "$scriptDir/copy-config.ps1"
& "$scriptDir/first-time-setup.ps1"
& "$scriptDir/setup-wsl.ps1"
