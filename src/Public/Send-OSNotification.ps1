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
    [CmdletBinding()]
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
            if ($Icon) {
                Write-Warning 'MacOS does not support the Icon parameter at this time.'
            }

            Pop-MacOSNotification -Body $Body -Title $Title
            break
        }
        $IsLinux {
            break
        }
        Default {
            # Must be Windows PowerShell
            break
        }
    }
}
