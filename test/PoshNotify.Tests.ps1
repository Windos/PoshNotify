Describe "Notification WhatIf tests" {
    Context "Send-OSNotification" {
        BeforeAll {
            Import-Module "$PSScriptRoot/../src/PoshNotify.psd1"
        }
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
                    $expected = "idk"
                    break
                }
                $IsLinux {
                    $expected = 'What if: Performing the operation "Pop-LinuxNotification" on target "running: PSNotifySend\Send-PSNotification -Body ''Hello World'' -Summary ''PowerShell Notification''".'
                    break
                }
                $IsMacOS {
                    $expected = 'What if: Performing the operation "Pop-MacOSNotification" on target "running: Invoke-MacNotification -Title ''PowerShell Notification'' -Message ''Hello World''".'
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
