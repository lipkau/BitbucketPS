function Import-MqcnAlias {
    [CmdletBinding()]
    param()

    begin {
        Set-Alias -Name ExportConfiguration -Value Configuration\Export-Configuration -Scope 1
    }
}
