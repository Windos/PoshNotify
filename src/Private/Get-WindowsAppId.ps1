# Helper function to get the relevant AppId for the calling PowerShell edition

function Get-WindowsAppId {
    if ($PSEdition -eq 'Desktop'){
        (Get-StartApps -Name 'PowerShell').where({$_.Name -eq 'Windows PowerShell'}).AppId
    } elseif ($PSVersionTable.PSVersion -ge [Version]'6.0') {
        Import-Module StartLayout -SkipEditionCheck
        (Get-StartApps -Name 'PowerShell').where({$_.Name -like 'PowerShell *'})[0].AppId
    } else {
        '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
    }
}
