[CmdletBinding()]
param(
    [switch]
    $Bootstrap,

    [switch]
    $Test
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

    if ($env:TF_BUILD) {
        $res = Invoke-Pester "$PSScriptRoot/test" -OutputFormat NUnitXml -OutputFile TestResults.xml -PassThru
        if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed." }
    } else {
        Invoke-Pester "$PSScriptRoot/test"
    }
}
