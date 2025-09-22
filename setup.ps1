$global:LogLevel = 0
$global:dryrun = $false

$global:ProjectRoot = $PSscriptRoot
$global:ScriptsDirectory = "$PSscriptRoot/scripts"
$global:UtilDirectory = "$ScriptsDirectory/utils"
$global:ModuleDirectory = "$ScriptsDirectory/modules"

Import-Module "$UtilDirectory/logging.ps1" -Scope Local -Force
Import-Module "$UtilDirectory/select-menu.ps1" -Scope Local -Force

# Ask if this run should be a dry run or not (default Yes)
$decision = $Host.UI.PromptForChoice('', 'Perform dryrun?', @('&Yes', '&No'), 0)
if ($decision -eq 0) { $global:dryrun = $true }

# Invoke default setup process
&{ . "$ModuleDirectory/scoop.ps1"; Install-Scoop }
&{ . "$ModuleDirectory/config.ps1"; Copy-Configs }

foreach ($postScript in Get-ChildItem "$ModuleDirectory/post-config" -Filter *.ps1) {
    Write-LogInfo "Found post script $postScript. Attempting to run Invoke-PostSetup"
    Write-LogDebug "Full path: $($postScript.FullName)"
    &{ . $postScript.FullName; Invoke-PostSetup }
}
