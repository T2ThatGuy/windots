Import-Module "$UtilDirectory/logging.ps1" -Scope Local
Import-Module "$UtilDirectory/select-menu.ps1" -Scope Local

$apps = @(
    "neovim"
    "fastfetch"
    "fzf"
    "eza"
    "zoxide"
    "extras/wezterm"
    "Flow-Launcher"
    "gh"
    "starship"
    "extras/everything"
    "extras/glazewm"
    "extras/zebar"
)

$buckets = @(
    "extras"
)

function Install-ScoopApps {
    Write-LogInfo "Starting scoop app install process"
    $appChoices = Get-SelectMenuChoice -Title "Select apps to install" -Options $apps -MultiSelect $true
    Write-LogDebug "Apps selected to install: $appChoices"

    $installedApps = scoop list
    foreach ($app in $appChoices) {
        if ($installedApps -match $app) { continue }
        if ($dryrun -eq $true) {
            Write-LogInfo "Skipping install of $app. Reason: Dry run enabled"
            continue
        }

        scoop install $app
    }
}

function Install-ScoopBuckets {
    Write-LogInfo "Starting scoop bucket install process"

    $installedBuckets = scoop bucket list
    foreach ($bucket in $buckets) {
        if ($installedBuckets -match $bucket) { continue }
        if ($dryrun -eq $true) {
            Write-LogInfo "Skipping install of $bucket. Reason: Dry run enabled"
            continue
        }

        scoop bucket add $bucket
    }
}

function Get-ScoopInstalled {
    try {
        scoop list
        return $true
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        Write-LogWarning "Couldn't run scoop list assuming scoop is uninstalled"
    }
    catch {
        Write-LogError "Some other error occurred when checking for scoop install: $_"
    }

    return $false
}

function Install-Scoop {
    if (Get-ScoopInstalled -not) {
        Write-LogInfo "Starting scoop download process"

        # See quickstart guide at https://scoop.sh/#/ for more information on below
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }

    Install-ScoopBuckets
    Install-ScoopApps
}
