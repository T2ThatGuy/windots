# --------------------------------------------------------
#                     Cli App Setups
# --------------------------------------------------------

# Starship
$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
Invoke-Expression (& "$HOME\scoop\apps\starship\current\starship.exe" init powershell)

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })


# --------------------------------------------------------
#                   Utility Functions
# --------------------------------------------------------

# Get all Env Variables
Function DisplayEnv {Get-ChildItem env:* | sort-object name | ? name -Like "*$args*"}
Set-Alias -Name env -Value DisplayEnv

# Search for file
Function SearchFile {(Get-ChildItem -n -Recurse -Path $args[0]) -match $args[1]}
Set-Alias -Name Grep-File -Value SearchFile

function mklink ($target, $link) { New-Item -Path $link -ItemType SymbolicLink -Value $target }


# --------------------------------------------------------
#                       Aliases
# --------------------------------------------------------

Set-Alias -Name vim -Value nvim
Set-Alias -Name touch -Value New-Item
Set-Alias -Name which -Value Show-Command

# Replace ls with eza
Function EzaList {
  [Alias('ls')]
  param(
    [string]$Path
  )

  eza --long --group-directories-first --git --icons $path
}


# --------------------------------------------------------
#                       Custom Env
# --------------------------------------------------------
$ENV:XDG_CONFIG_HOME = "$HOME\.config"


# Run a fast fetch and end of profile
fastfetch
