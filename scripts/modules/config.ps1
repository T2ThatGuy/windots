Import-Module "$UtilDirectory/logging.ps1" -Scope Local
Import-Module "$UtilDirectory/select-menu.ps1" -Scope Local

$srcConfigDir = "$ProjectRoot/config"
$configDir = "$home/config"

# All files and folders follow the format
# Application Name => (Source, Destination)

$appConfigFolders = @{
    # =-=-=- Window Manager -=-=-=
    "zebar"   = @("$srcConfigDir/zebar", "$home/.glzr/zebar")
    "glazewm" = @("$srcConfigDir/glazewm", "$home/.glzr/glazewm")

    # =-=-=- Terminal Apps -=-=-=
    "nvim"      = @("$srcConfigDir/nvim", "$configDir/nvim")
    "starship"  = @("$srcConfigDir/starship", "$home/starship")
    "wezterm"   = @("$srcConfigDir/wezterm", "$configDir/wezterm")
    "fastfetch" = @("$srcConfigDir/fastfetch", "$configDir/fastfetch")
}

$appConfigFiles = @{
    "powershell" = @("$srcConfigDir/powershell/profile.ps1", $profile)
}

function Copy-Configs {
    $choiceMenuOptions = @{
        Title = "Select config modules to copy across"
        Options = $appConfigFolders.Keys + $appConfigFiles.Keys
        MultiSelect = $true
    }

    $choices = Get-SelectMenuChoice @choiceMenuOptions

    Write-LogDebug "Configs selected to copy: $choices"

    foreach ($folder in $appConfigFiles.Values) {
        $src, $destination = $folder
        Copy-ConfigFile -Src $src -Destination $destination
    }

    foreach ($folder in $appConfigFolders) {
        $src, $destination = $folder
        Copy-ConfigFolder -Src $src -Destination $destination
    }
}

function Copy-ConfigFile {
    param (
        [string]$Src,
        [string]$Destination
    )

    if ($dryrun -eq $true) {
        Write-LogInfo "Skipping file $Src. Reason: Dry run enabled"
        return
    }

    $fileExists = Test-Path -Path $Destination
    if ($fileExists -eq $true) {
        Write-LogDebug "Deleting existing config location: $Destination"
        Remove-Item -Path $Destination -Force | out-null
    }

    Copy-Item $Src -Destination $Destination -Force | out-null
    Write-Host "Copied file $Src -> $Destination"
}

function Copy-ConfigFolder {
    param (
        [string]$Src,
        [string]$Destination
    )

    if ($dryrun -eq $true) {
        Write-LogInfo "Skipping folder $Src. Reason: Dry run enabled"
        return
    }

    $folderExists = Test-Path -Path $Destination
    if ($folderExists -eq $true) {
        Write-LogDebug "Deleting existing config location: $Destination"
        Remove-Item -Path $folderExists -Recurse -Force | out-null
    }

    Copy-Item $Src -Destination $Destination -Recurse -Force | out-null
    Write-Host "Copied folder $Src -> $Destination"
}
