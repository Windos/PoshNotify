# The function that handles Linux notifications
<#
$Source = @"
Class SoundNames : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        $SoundPaths = '/usr/share/sounds/gnome/default/alerts'
        $SoundNames = ForEach ($SoundPath in $SoundPaths) {
            If (Test-Path $SoundPath) {
                Get-ChildItem $SoundPath | Select Basename,Fullname
            }
        }
        return [string[]] $SoundNames
    }
}
"@

Add-Type -TypeDefinition $Source -Language CSharp
#>


function Pop-LinuxNotification {

    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]
        $Body,

        [Parameter(Mandatory=$true)]
        [string]
        $Title,

        [Parameter()]
        [string]
        $Icon,

        [Parameter()]
        [Alias('Sound')]
        #[ValidateSet([SoundNames])]
        [string]
        $Soundfile = '/usr/share/sounds/gnome/default/alerts/bark.ogg'

    )

    $splat = @{
        Body = $Body
        Summary = $Title
    }

    if ($Icon) {
        $splat.Add('Icon', $Icon)
    }

    if ($Soundfile){
        $splat.Add('Sound',$Soundfile.Fullname)
    }

    if($PSCmdlet.ShouldProcess("running: PSNotifySend\Send-PSNotification $(ConvertTo-ParameterString $splat)")) {
        PSNotifySend\Send-PSNotification @splat
    }
}