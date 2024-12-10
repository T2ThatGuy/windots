# All files and folders follow the format
# (Source => Destination)

$folders = @()

$files = @{
    "./config/powershell/Microsoft.PowerShell_profile.ps1" = $profile
}

Write-Host "--- Copying config (files)"
foreach ($file in $files.GetEnumerator()) {
    if ($dryrun -eq $True) {
        Write-Host "- Skipping file"$file.key". Reason: Dry run enabled"
        continue
    }

    $fileExists = Test-Path $file.Value
    if ($fileExists -eq $False) {
        New-Item -ItemType File -Path $file.Value -Force | out-null
    }

    Copy-Item $file.key -Destination $file.Value -Force | out-null
    Write-Host "-- Copied file"$file.key"to"$file.Value
}
