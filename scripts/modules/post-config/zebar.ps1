Import-Module "$UtilDirectory/logging.ps1" -Scope Local
Import-Module "$UtilDirectory/select-menu.ps1" -Scope Local

$zebarAppLocation = "$home/.glzr/zebar/custom"
$zebarEnvLocation = "$zebarAppLocation/.env"

function Invoke-PostSetup {
    Write-LogInfo "Starting post setup script for zebar"

    if (-not $(Test-Path -Path $zebarAppLocation)) {
        Write-LogWarning "Install location for $zebarAppLocation not found skipping zebar setup"
        return
    }

    Invoke-ZebarSetup
    Invoke-ZebarBuild
}

function Invoke-ZebarSetup {
    Write-LogDebug "Starting zebar additional config setup"

    $decisionOptions = @{
        Title = "`nTo enable / disable certain modules`nIs this device a laptop?"
        Options = @("Yes", "No")
    }

    $decision = Get-SelectMenuChoice @decisionOptions

    if ($decision[0] -eq "No") {
        Write-LogDebug "Skipping env setup for laptop. Reason: User opted out"
        return
    }

    Write-LogInfo "Adding VITE_LAPTOP_MODE environment variable"
    if ($dryrun -eq $true) {
        Write-LogInfo "Skipping env update for $zebarEnvLocation. Reason: Dry run enabled"
        return
    }

    $envFileExists = Test-Path -Path $zebarEnvLocation
    if ($envFileExists -eq $True) {
        Write-LogDebug "Removing .env file at "$zebarEnvLocation
        Remove-Item -Path $zebarEnvLocation
    }

    New-Item -ItemType File -Path $zebarEnvLocation -Force | out-null
    Add-Content -Path $zebarEnvLocation -Value "VITE_LAPTOP_MODE=1" | out-null
}

function Invoke-ZebarBuild {
    Write-LogInfo "Starting zebar application build"

    if ($dryrun -eq $true) {
        Write-LogInfo "Skipping zebar build. Reason: Dry run enabled"
        return
    }

    Write-LogDebug "Chaging directory to "$zebarLocation
    Set-Location $zebarAppLocation

    npm ci
    npm run build

    Write-LogDebug "Changing directory back to scripts directory "$ScriptsDirectory
    Set-Location $ScriptsDirectory
}
