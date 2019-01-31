<#
.Synopsis
	Build script (https://github.com/nightroman/Invoke-Build)
#>

# Thanks to Stephan Stranger
# https://stefanstranger.github.io/2018/12/30/UseAzurePipelinesToPublishPowerShellModule/

param ($Configuration = 'Development')

#region use the most strict mode
Set-StrictMode -Version Latest
#endregion

#region Task to Copy PowerShell Module files to output folder for release as Module
task CopyModuleFiles {

    # Copy Module Files to Output Folder
    if (-not (Test-Path .\output\PoshNotify)) {

        $null = New-Item -Path .\output\PoshNotify -ItemType Directory

    }

    Copy-Item -Path '.\src\*' -Filter *.* -Recurse -Destination .\output\PoshNotify -Force

    # Copy Module README file
    Copy-Item -Path '.\README.md' -Destination .\output\PoshNotify -Force
}
#endregion

#region Task to Publish Module to PowerShell Gallery
task PublishModule -If ($Configuration -eq 'Production') {
    Try {
        # Build a splat containing the required details and make sure to Stop for errors which will trigger the catch
        $params = @{
            Path        = ('{0}\Output\PoshNotify' -f $PSScriptRoot )
            NuGetApiKey = $env:psgallery
            ErrorAction = 'Stop'
        }
        Publish-Module @params
        Write-Output -InputObject ('PoshNotify PowerShell Module version published to the PowerShell Gallery')
    }
    Catch {
        throw $_
    }
}
#endregion

#region Task clean up Output folder
task Clean {
    # Clean output folder
    if ((Test-Path .\output)) {

        Remove-Item -Path .\Output -Recurse -Force

    }
}
#endregion

#region Default Task. Runs Clean, Test, CopyModuleFiles Tasks
task . Clean, Test, CopyModuleFiles, PublishModule
#endregion