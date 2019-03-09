if($IsMacOS -and !(Get-Module MacNotify -list)) {
    Install-Module MacNotify
}

if($IsMacOS -and (Get-Module MacNotify -list)) {
    Update-Module MacNotify
}

if($IsLinux -and !(Get-Module PSNotifySend -list)) {
    Install-Module PSNotifySend
}

if($IsLinux -and (Get-Module PSNotifySend -list)) {
    Update-Module PSNotifySend
}

#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$ModuleRoot = $PSScriptRoot

#Dot source the files
foreach($import in @($Public + $Private))
{
    try
    {
        . $import.fullname
    }
    catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}
