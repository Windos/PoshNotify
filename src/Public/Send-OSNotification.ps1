<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER Body
Parameter description

.PARAMETER Title
Parameter description

.PARAMETER Icon
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
function Send-OSNotification {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]
        $Body,

        [Parameter()]
        [string]
        $Title = 'PowerShell Notification',

        [Parameter()]
        [string]
        $Icon
    )

    switch ($true) {
        $IsWindows {
            break
        }
        $IsMacOS {
            Pop-MacOSNotification -Body $Body -Title $Title -Icon $Icon
            break
        }
        $IsLinux {
            Pop-LinuxNotification -Body $Body -Title $Title -Icon $Icon
            break
        }
        Default {
            # Must be Windows PowerShell
            break
        }
    }
}
