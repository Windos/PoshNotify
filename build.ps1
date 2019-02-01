[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Test,

    [switch]
    $Publish
)

# Bootstrap step
if ($Bootstrap.IsPresent) {
    Write-Host "Validate and install missing prerequisits for building ..."

    # Dependencies of PoshNotify
    if (-not (Get-Module -Name MacNotify -ListAvailable)) {
        Write-Warning "Module 'MacNotify' is missing. Installing 'MacNotify' ..."
        Install-Module -Name MacNotify -Scope CurrentUser -Force
    }
    if (-not (Get-Module -Name PSNotifySend -ListAvailable)) {
        Write-Warning "Module 'PSNotifySend' is missing. Installing 'PSNotifySend' ..."
        Install-Module -Name PSNotifySend -Scope CurrentUser -Force
    }

    # For testing
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        Write-Warning "Module 'Pester' is missing. Installing 'Pester' ..."
        Install-Module -Name Pester -Scope CurrentUser -Force
    }
}

# Test step
if($Test.IsPresent) {
    if (-not (Get-Module -Name Pester -ListAvailable)) {
        throw "Cannot find the 'Pester' module. Please specify '-Bootstrap' to install build dependencies."
    }

    $PSFiles = (Get-ChildItem $PSScriptRoot/src -Recurse -Include "*.psm1","*.ps1").FullName

    if ($env:TF_BUILD) {
        $res = Invoke-Pester "$PSScriptRoot/test" -CodeCoverage $PSFiles -OutputFormat NUnitXml -OutputFile TestResults.xml -PassThru
        if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
    } else {
        $res = Invoke-Pester -Path "$PSScriptRoot/test" -CodeCoverage $PSFiles -PassThru
    }

    [math]::floor(100 - (($res.CodeCoverage.NumberOfCommandsMissed / $res.CodeCoverage.NumberOfCommandsAnalyzed) * 100))
}

if($Publish.IsPresent) {
    if ((Test-Path .\output)) {
        Remove-Item -Path .\Output -Recurse -Force
    }

    # Copy Module Files to Output Folder
    if (-not (Test-Path .\output\PoshNotify)) {

        $null = New-Item -Path .\output\PoshNotify -ItemType Directory

    }

    Copy-Item -Path '.\src\*' -Filter *.* -Recurse -Destination .\output\PoshNotify -Force

    # Copy Module README file
    Copy-Item -Path '.\README.md' -Destination .\output\PoshNotify -Force

    # Publish Module to PowerShell Gallery
    Try {
        # Build a splat containing the required details and make sure to Stop for errors which will trigger the catch
        $params = @{
            Path        = ('{0}\Output\PoshNotify' -f $PSScriptRoot )
            NuGetApiKey = $env:psgallery
            ErrorAction = 'Stop'
        }
        Publish-Module @params
        Write-Output -InputObject ('PoshNotify PowerShell Module version published to the PowerShell Gallery')
    }
    Catch {
        throw $_
    }
}