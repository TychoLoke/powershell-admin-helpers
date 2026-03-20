@{
    RootModule = 'PowerShellAdminHelpers.psm1'
    ModuleVersion = '0.2.0'
    GUID = '7f4b158b-2d3d-4c8d-a2ee-2ae3866fc002'
    Author = 'Tycho Loke'
    CompanyName = 'Tycho Loke'
    Copyright = '(c) 2026 Tycho Loke'
    Description = 'Reusable helper functions for Microsoft admin and automation scripts.'
    FunctionsToExport = @(
        'Ensure-Module',
        'Ensure-OutputDirectory',
        'Export-ObjectBundle',
        'Connect-GraphWithScopes'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    PowerShellVersion = '7.0'
}
