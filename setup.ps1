Import-Module "$PSscriptRoot/scripts/utils/logging.ps1" -Scope Local -Force

$global:LogLevel = 0
$global:dryrun = $false

$global:ScriptsDirectory = "$PSscriptRoot/scripts"
$global:UtilDirectory = "$ScriptsDirectory/utils"

# Ask if this run should be a dry run or not (default Yes)
$decision = $Host.UI.PromptForChoice('', 'Perform dryrun?', @('&Yes', '&No'), 0)
if ($decision -eq 0) { $global:dryrun = $true }


# $scriptDir = "$PSscriptRoot\scripts"
# & "$scriptDir/install-apps.ps1"
# & "$scriptDir/copy-config.ps1"
# & "$scriptDir/first-time-setup.ps1"
# & "$scriptDir/setup-wsl.ps1"
