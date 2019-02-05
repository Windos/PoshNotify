# PoshNotify

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/df16709e5785414fad6a2f21dce1242d)](https://www.codacy.com/app/Windos/PoshNotify?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Windos/PoshNotify&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/Windos/PoshNotify/branch/master/graph/badge.svg)](https://codecov.io/gh/Windos/PoshNotify)
[![Build Status](https://dev.azure.com/windosnz/PoshNotify/_apis/build/status/Windos.PoshNotify)](https://dev.azure.com/windosnz/PoshNotify/_build/latest?definitionId=1)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/PoshNotify.svg)](https://www.powershellgallery.com/packages/PoshNotify)

[![Platforms](https://img.shields.io/powershellgallery/p/PoshNotify.svg)](https://www.powershellgallery.com/packages/PoshNotify)
![Top Language](https://img.shields.io/github/languages/top/Windos/PoshNotify.svg)
![Code Size](https://img.shields.io/github/languages/code-size/Windos/PoshNotify.svg)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/PoshNotify.svg)](https://www.powershellgallery.com/packages/PoshNotify)
![Open Issues](https://img.shields.io/github/issues-raw/Windos/PoshNotify.svg)

Cross-platform PowerShell module for generating toast notifications on Linux, macOS, and Windows 10.

![PoshNotify Icon](/media/PoshNotify.png)

## Examples

### Script Completion

```powershell
Send-OSNotification -Title 'Script Completed' -Body "The script you were running finished at $(Get-Date -Format t)"
```

#### Windows

![Windows result script completion](/media/Win-Report.png)

#### macOS

![macOS result script completion](/media/Mac-Report.png)

#### Linux

![Linux result script completion](/media/Linux-Report.png)
