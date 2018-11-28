# The function that handles macOS notifications
function Pop-MacOSNotification {
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

    # If the command requires advanced features, we should use alerter.
    # This if contains all the parameters that would need it.
    if ($Icon) {
        $splat = @{
            Message = $Body
            Title = $Title
            Timeout = 4
            Silent = $true
        }

        if ($Icon) {
            $splat.Add('AppIcon', $Icon)
        }
        if($PSCmdlet.ShouldProcess("running: Invoke-AlerterNotification $(ConvertTo-ParameterString $splat)")) {
            MacNotify\Invoke-AlerterNotification @splat
        }
    } else {
        $splat = @{
            Message = $Body
            Title = $Title
        }
        if($PSCmdlet.ShouldProcess("rrunning: Invoke-MacNotification $(ConvertTo-ParameterString $splat)")) {
            MacNotify\Invoke-MacNotification @splat
        }
    }
}
