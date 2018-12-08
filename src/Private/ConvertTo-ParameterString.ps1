# A helper function to best-effort convert a hashtable that will be splatted, to a param string
# ex. -Body 'Hello World' -Timeout 4
function ConvertTo-ParameterString {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [hashtable]
        $InputObject
    )
    $paramsArray = @()
    foreach ($dictionaryEntry in ($InputObject.GetEnumerator() | Sort-Object Key)) {
        $paramsArray += "-$($dictionaryEntry.Key)"

        if ($dictionaryEntry.Value.GetType() -eq [string]) {
            $paramsArray += "'$($dictionaryEntry.Value)'"
        } else {
            $paramsArray += "$($dictionaryEntry.Value)"
        }
    }

    $paramsArray -join ' '
}
