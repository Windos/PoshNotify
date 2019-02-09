<#
.SYNOPSIS
Displays toast notifications on Linux, macOS, and Windows.

.DESCRIPTION
The Send-OSNotification function displays notification on Linux, macOS, and Windows.

Each operating system uses different methods for generating and displaying notifications, but this function abstracts
each of them for a consistent experience regardless of the environment in which it is used.

.PARAMETER Body
The main text of your notification. You must specify a body string.

.PARAMETER Title
The title of your notification. Generally this is rendered bold at the top of the notification.

Defaults to "PowerShell Notification".

.PARAMETER Icon
If specified, the specified picture is included on the notification.

There is a default Icon included on Windows only.

.PARAMETER Sound
If specified, the specified sound will be played along with the notification.

.EXAMPLE
Send-OSNotification -Title 'Script Completed' -Body "The script you were running finished at $(Get-Date -Format t)"

This command generates a notification that includes the time at which it was generated in the body.

.LINK
https://github.com/Windos/PoshNotify/tree/master/docs/Send-OSNotification.md

.NOTES
Notifications are "best effort". Certain features may not be supported on all platforms but PoshNotify will still
attempt to send a notification with as much of the information provided as it can.

This function relies on the MacNotify module on macOS, and the PSNotifySend module on Linux.
#>
function Send-OSNotification {
    [CmdletBinding(SupportsShouldProcess=$true,HelpUri="https://github.com/Windos/PoshNotify/tree/master/docs/Send-OSNotification.md")]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]
        $Body,

        [Parameter()]
        [string]
        $Title = 'PowerShell Notification',

        [Parameter()]
        [string]
        $Icon,

        [Parameter()]
        [string]
        $Sound
    )

    $splat = @{
        Body = $Body
        Title = $Title
    }

    if ($Icon) {
        $splat.Add('Icon', $Icon)
    }

    if ($Sound) {
        $splat.Add('Sound', $Sound)
    }

    switch ($true) {
        $IsWindows {
            # Must be PowerShell Core on Windows
            Pop-WindowsNotification @splat
            break
        }
        $IsMacOS {
            Pop-MacOSNotification @splat
            break
        }
        $IsLinux {
            Pop-LinuxNotification @splat
            break
        }
        Default {
            # Must be Windows PowerShell
            Pop-WindowsNotification @splat
            break
        }
    }
}
