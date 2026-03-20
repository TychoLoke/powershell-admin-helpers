[CmdletBinding()]
param(
    [string]$Ref = "main",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Get-CurrentUserModulePath {
    if ($IsWindows) {
        return Join-Path -Path $HOME -ChildPath "Documents\PowerShell\Modules"
    }

    return Join-Path -Path $HOME -ChildPath ".local/share/powershell/Modules"
}

$moduleRoot = Join-Path -Path (Get-CurrentUserModulePath) -ChildPath "PowerShellAdminHelpers"
$baseUri = "https://raw.githubusercontent.com/TychoLoke/powershell-admin-helpers/$Ref/PowerShellAdminHelpers"

if ((Test-Path -Path $moduleRoot) -and -not $Force) {
    Write-Host "PowerShellAdminHelpers is already installed at $moduleRoot"
} else {
    New-Item -Path $moduleRoot -ItemType Directory -Force | Out-Null

    $files = @(
        "PowerShellAdminHelpers.psd1",
        "PowerShellAdminHelpers.psm1"
    )

    foreach ($file in $files) {
        $destination = Join-Path -Path $moduleRoot -ChildPath $file
        $uri = "$baseUri/$file"
        Invoke-WebRequest -Uri $uri -OutFile $destination
    }

    Write-Host "Installed PowerShellAdminHelpers to $moduleRoot"
}

Import-Module -Name (Join-Path -Path $moduleRoot -ChildPath "PowerShellAdminHelpers.psd1") -Force -ErrorAction Stop
Write-Host "Imported PowerShellAdminHelpers"
