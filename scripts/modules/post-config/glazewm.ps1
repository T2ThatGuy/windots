Import-Module "$UtilDirectory/logging.ps1" -Scope Local
Import-Module "$UtilDirectory/select-menu.ps1" -Scope Local

$glazewmConfigLocation = "$home/.glzr/glazewm/config.yaml"

function Invoke-PostSetup {
    Write-LogInfo "Starting post setup script for glazewm"

    if (-not $(Test-Path -Path $glazewmConfigLocation)) {
        Write-LogDebug "Install location not found skipping glazewm post config setup"
        return
    }

    Set-WorkspaceConfig
}

function Set-WorkspaceConfig {
    Write-LogDebug "Starting glazewm additional config setup"
    $monitorOptions = @{
        Title = "`nTo get the intended workspace setup`nHow many monitors are expected?"
        Options = @("1", "2", "3")
    }
    
    $choices = Get-SelectMenuChoice @monitorOptions
    $workspaceFile = "$home/.glzr/glazewm/workspaces-$($choices[0])-monitors.yaml"

    Write-LogInfo "Adding $workspaceFile to $glazewmConfigLocation"
    if ($dryrun -eq $true) {
        Write-LogInfo "Skipping write. Reason: Dry run enabled"
        return
    }
    
    Add-Content -Path "$home/.glzr/glazewm/config.yaml" -Value $(Get-Content $workspaceFile) | out-null
}
