function InstallWSL {
    Write-Host "-- Installing WSL"
    if ($dryrun -eq $true) {
        Write-Host "- Skipping WSL install. Reason: Dry run"
        return
    }

    # Enabled Features
    sudo dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    sudo dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

    # Make sure to use WSL version 2
    wsl.exe --update
    wsl --set-default-version 2
}

function InstallUbuntu {
    Write-Host "-- Installing Ubuntu"
    if ($dryrun -eq $true) {
        Write-Host "- Skipping Ubuntu install. Reason: Dry run"
        return
    }

    wsl --install Ubuntu-24.04 --name Ubuntu24 --no-launch

    # Check its installed before continuing
    $timeout = 30
    $counter = 0

    while ($counter -lt $timeout) {
        $distroList = wsl -l
        if ($distroList -match "Ubuntu24") {
            break
        }

        Start-Sleep -Seconds 1
        $counter++
    }
}

function SetupUbuntu {
    Write-Host "-- Setting up Ubuntu"
    if ($dryrun -eq $true) {
        Write-Host "- Skipping Ubuntu setup. Reason: Dry run"
        return
    }

    wsl --distribution Ubuntu24 -- bash -c "echo 'Hello from Ubuntu!'"
}

Write-Host "--- Performing setup for WSL (Ubuntu 24.04)"
$decision = $Host.UI.PromptForChoice('Confirmation', 'Would you like to proceed with the installation?', @('&Yes', '&No'), 1)

if ($decision -eq 0) {
    InstallWSL
    InstallUbuntu
    SetupUbuntu
}
