
$LevelMap = @{
    "DEBUG" = 0
    "INFO" = 1
    "WARN" = 2
    "ERROR" = 3
}

function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("INFO","WARN","ERROR","DEBUG")]
        [string]$Level,

        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    if ($LevelMap[$Level] -lt $LogLevel) { return }

    # Define colors per level
    switch ($Level) {
        "INFO"  { $color = "Cyan" }
        "WARN"  { $color = "Yellow" }
        "ERROR" { $color = "Red" }
        "DEBUG" { $color = "Gray" }
    }

    # Get caller information
    $callerFunction = (Get-PSCallStack | Select-Object -Skip 1 -First 1).FunctionName
    if (-not $callerFunction) { $callerFunction = "<Script>" }

    $formattedMessage = ""

    if ($LogLevel -eq 0) {
        $callerScript = $(Split-Path $MyInvocation.PSCommandPath -Leaf)
        if (-not $callerScript) { $callerScript = "<Console>" }

        $formattedMessage += "[$callerScript::$callerFunction] "
    }

    $formattedMessage = "[$Level] $Message"
    Write-Host $formattedMessage -ForegroundColor $color
}

function Write-LogDebug {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Log -Level DEBUG -Message $Message
}

function Write-LogInfo {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Log -Level INFO -Message $Message
}

function Write-LogWarning {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Log -Level WARN -Message $Message
}

function Write-LogError {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Log -Level ERROR -Message $Message
}

