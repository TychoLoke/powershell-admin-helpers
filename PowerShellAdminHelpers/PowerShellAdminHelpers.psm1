function Ensure-Module {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModuleName
    )

    if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
        Install-Module -Name $ModuleName -Scope CurrentUser -Force
    }

    Import-Module -Name $ModuleName -ErrorAction Stop
}

function Ensure-OutputDirectory {
    [CmdletBinding()]
    param(
        [string]$Path
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return
    }

    if (-not (Test-Path -Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
    }
}

function Export-ObjectBundle {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$OutputDirectory,

        [Parameter(Mandatory = $true)]
        [string]$SectionName,

        [Parameter(Mandatory = $true)]
        $Data
    )

    Ensure-OutputDirectory -Path $OutputDirectory

    $jsonPath = Join-Path -Path $OutputDirectory -ChildPath "$SectionName.json"
    $Data | ConvertTo-Json -Depth 10 | Set-Content -Path $jsonPath -Encoding UTF8

    if ($Data -is [System.Collections.IEnumerable] -and -not ($Data -is [string])) {
        try {
            $csvPath = Join-Path -Path $OutputDirectory -ChildPath "$SectionName.csv"
            $Data | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        } catch {
            Write-Warning "Skipped CSV export for $SectionName because the data shape is not flat enough."
        }
    }
}

function Connect-GraphWithScopes {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Scopes,

        [string]$TenantId
    )

    Ensure-Module -ModuleName Microsoft.Graph.Authentication

    $context = Get-MgContext
    $missingScopes = @(
        foreach ($scope in $Scopes) {
            if (-not $context -or $scope -notin $context.Scopes) {
                $scope
            }
        }
    )

    if ($missingScopes.Count -gt 0) {
        if ($context) {
            Disconnect-MgGraph | Out-Null
        }

        if ($TenantId) {
            Connect-MgGraph -TenantId $TenantId -Scopes $Scopes -NoWelcome
        } else {
            Connect-MgGraph -Scopes $Scopes -NoWelcome
        }
    }
}

Export-ModuleMember -Function Ensure-Module, Ensure-OutputDirectory, Export-ObjectBundle, Connect-GraphWithScopes
