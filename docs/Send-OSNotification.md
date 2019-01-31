# Send-OSNotification

## SYNOPSIS

Displays toast notifications on Linux, macOS, and Windows.

## SYNTAX

### Body

```powershell
Send-OSNotification -Body <String>
```

### Title

```powershell
Send-OSNotification -Body <string> [-Title <string>]
```

### Icon

```powershell
Send-OSNotification -Body <string> [-Title <string> -Icon <string>]
```

## DESCRIPTION

The Send-OSNotification function displays notification on Linux, macOS, and Windows.

Each operating system uses different methods for generating and displaying notifications, but this function abstracts
each of them for a consistent experience regardless of the environment in which it is used.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

Send-OSNotification -Title 'Script Completed' -Body "The script you were running finished at $(Get-Date -Format t)"

This command generates a notification that includes the time at which it was generated in the body.

## PARAMETERS

### -Body

The main text of your notification. You must specify a body string.

```yaml
Type: String
Parameter Sets:
Aliases:
Accepted values:

Required: True
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

The title of your notification. Generally this is rendered bold at the top of the notification.

```yaml
Type: String
Parameter Sets:
Aliases:
Accepted values:

Required:
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon

If specified, the specified picture is included on the notification.

```yaml
Type: String
Parameter Sets:
Aliases:
Accepted values:

Required:
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

Body

## OUTPUTS

## NOTES

Notifications are "best effort". Certain features may not be supported on all platforms but PoshNotify will still
attempt to send a notification with as much of the information provided as it can.

This function relies on the MacNotify module on macOS, and the PSNotifySend module on Linux.

## RELATED LINKS
