function Pop-MacOSNotification {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]
        $Body,

        [Parameter(Mandatory=$true)]
        [string]
        $Title
    )

    MacNotify\Invoke-MacNotification -Message $Body -Title $Title
}