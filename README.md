# PowerShell Admin Helpers

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
