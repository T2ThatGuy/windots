
# Ask if this run should be a dry run or not (default Yes)
$decision = $Host.UI.PromptForChoice('', 'Perform dryrun?', @('&Yes', '&No'), 0)
if ($decision -eq 0) {
    $dryrun = $true
} else {
    $dryrun = $false
}

& "$PSScriptRoot\scripts\install-apps.ps1"
& "$PSScriptRoot\scripts\copy-config.ps1"
