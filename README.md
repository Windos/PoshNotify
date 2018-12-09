![PoshNotify Icon](/media/PoshNotify.png)

# PoshNotify
Cross-platform PowerShell module for generating toast notifications on Linux, macOS, and Windows.

[![Build Status](https://dev.azure.com/windosnz/PoshNotify/_apis/build/status/Windos.PoshNotify)](https://dev.azure.com/windosnz/PoshNotify/_build/latest?definitionId=1)

## Examples

### Script Completion

```powershell
Send-OSNotification -Title 'Script Completed' -Body "The script you were running finished at $(Get-Date -Format t)"
```

#### Windows

![Windows result script completion](/media/Win-Report.png)

#### macOS

![macOS result script completion](/media/Mac-Report.png)
