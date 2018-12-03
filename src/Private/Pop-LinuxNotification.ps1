# The function that handles Linux notifications
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
        $Icon
    )

    $splat = @{
        Body = $Body
        Summary = $Title
    }

    if ($Icon) {
        $splat.Add('Icon', $Icon)
    }

    if($PSCmdlet.ShouldProcess("running: PSNotifySend\Send-PSNotification $(ConvertTo-ParameterString $splat)")) {
        PSNotifySend\Send-PSNotification @splat
    }
}
