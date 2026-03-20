# PowerShell Admin Helpers

[![Release](https://img.shields.io/github/v/release/TychoLoke/powershell-admin-helpers)](https://github.com/TychoLoke/powershell-admin-helpers/releases)
[![CI](https://img.shields.io/github/actions/workflow/status/TychoLoke/powershell-admin-helpers/powershell-ci.yml?branch=main)](https://github.com/TychoLoke/powershell-admin-helpers/actions/workflows/powershell-ci.yml)

Reusable helper functions for Microsoft admin and automation scripts.

## Included Helpers

- `Ensure-Module`: install and import a PowerShell module for the current user.
- `Ensure-OutputDirectory`: create an output directory if it does not exist.
- `Export-ObjectBundle`: export structured data to JSON and optionally CSV.
- `Connect-GraphWithScopes`: connect to Microsoft Graph with a defined set of delegated scopes.

## Import

```powershell
Import-Module .\PowerShellAdminHelpers\PowerShellAdminHelpers.psd1 -Force
```

## Install From GitHub

```powershell
Invoke-WebRequest `
  -Uri "https://raw.githubusercontent.com/TychoLoke/powershell-admin-helpers/main/Install-PowerShellAdminHelpers.ps1" `
  -OutFile "$env:TEMP\Install-PowerShellAdminHelpers.ps1"

& "$env:TEMP\Install-PowerShellAdminHelpers.ps1"
```

This installs the module into the current user PowerShell module path and imports it for the current session.

## Example

```powershell
Import-Module .\PowerShellAdminHelpers\PowerShellAdminHelpers.psd1 -Force

Ensure-Module -ModuleName Microsoft.Graph
Connect-GraphWithScopes -Scopes @("Directory.Read.All")

$data = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/organization"
Export-ObjectBundle -OutputDirectory "C:\Temp\Exports" -SectionName "Organization" -Data $data
```

## Status

This repo is intended as the shared helper base for TychoLoke PowerShell automation repos.
