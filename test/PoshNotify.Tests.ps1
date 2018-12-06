Import-Module "$PSScriptRoot/../src/PoshNotify.psd1" -Force
if ($PSEdition -eq 'Desktop'){
    $appId = (Get-StartApps -Name 'PowerShell').where({$_.Name -eq 'Windows PowerShell'}).AppId
} elseif ($IsWindows -and $PSVersionTable.PSVersion -ge [Version]'6.1') {
    Import-Module StartLayout -SkipEditionCheck
    $appId = (Get-StartApps -Name 'PowerShell').where({$_.Name -like 'PowerShell 6*'})[0].AppId
} else {
    $appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
}

Describe "Notification WhatIf tests" {
    Context "Send-OSNotification" {
        It "Should fire a notification" {
            # Since it's non-trivial to detect the notification that gets fired on each platform,
            # we are testing using WhatIf and verifying the operation that would be performed.
            Start-Transcript tmp.log
            try {
                Send-OSNotification "Hello World" -WhatIf
            }
            finally {
                Stop-Transcript
            }

            $log = Get-Content tmp.log | Where-Object { $_ -match "What if: Performing the operation" }
            Remove-Item tmp.log

            switch ($true) {
                $IsWindows {
                    $expected = 'What if: Performing the operation "Pop-WindowsNotification" on target "running: CreateToastNotifier method with AppId ' + $appId + ' and XML Payload:
    <toast>
    <visual>
        <binding template="ToastGeneric">
        <text>PowerShell Notification</text>
        <text>Hello World</text>
        <image src="" placement="appLogoOverride" hint-crop="circle" />
        </binding>
    </visual>
    <audio src="ms-winsoundevent:Notification.Default" />
    </toast>".'
                    break
                }
                $IsLinux {
                    $expected = 'What if: Performing the operation "Pop-LinuxNotification" on target "running: PSNotifySend\Send-PSNotification -Body ''Hello World'' -Summary ''PowerShell Notification''".'
                    break
                }
                $IsMacOS {
                    $expected = 'What if: Performing the operation "Pop-MacOSNotification" on target "running: Invoke-MacNotification -Message ''Hello World'' -Title ''PowerShell Notification''".'
                    break
                }
                default {
                    #Windows PowerShell
                    $expected = "idk"
                    break
                }
            }

            $log | Should -Be $expected
        }
    }
}
