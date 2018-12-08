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

    $splat = @{
        Body = $Body
        Title = $Title
    }

    if ($Icon) {
        $splat.Add('Icon', $Icon)
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
