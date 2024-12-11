# All files and folders follow the format
# (Source => Destination)

$configDir = "./config"
$folders = @{
    "$configDir/glzr" = "$home/.glzr"
    "$configDir/starship" = "$home/.starship"
    "$configDir/fastfetch" = "$home/.config/fastfetch"
    "$configDir/wezterm" = "$home/.config/wezterm"
}

$files = @{
    "$configDir/powershell/Microsoft.PowerShell_profile.ps1" = $profile
}

Write-Host "--- Copying config (files)"
foreach ($file in $files.GetEnumerator()) {
    if ($dryrun -eq $True) {
        Write-Host "- Skipping file"$file.key". Reason: Dry run enabled"
        continue
    }

    $fileExists = Test-Path -Path $file.Value
    if ($fileExists -eq $False) {
        New-Item -ItemType File -Path $file.Value -Force | out-null
    }

    Copy-Item $file.key -Destination $file.Value -Force | out-null
    Write-Host "-- Copied file"$file.key"to"$file.Value
}

Write-Host "--- Copying config (folders)"
foreach ($folder in $folders.GetEnumerator()) {
    if ($dryrun -eq $True) {
        Write-Host "- Skipping folder"$file.key". Reason: Dry run enabled"
        continue
    }

    $folderExists = Test-Path -Path $folder.Value
    if ($folderExists -eq $True) {
        Remove-Item -Path $folder.Value -Recurse -Force | out-null
    }

    Copy-Item $folder.key -Destination $folder.Value -Recurse -Force | out-null
    Write-Host "-- Copied folder"$folder.key"to"$folder.Value
}
