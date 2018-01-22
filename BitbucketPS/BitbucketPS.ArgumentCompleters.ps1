function ServerNameCompletion {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Write-Host (Get-Configuration | out-string)
    # $script:Configuration.Server |
    #     # Where-Object { $_.Name -like "$wordToComplete*" } |
    #     ForEach-Object {
    #         New-CompletionResult -CompletionText $_
    #     }
    # New-CompletionResult -CompletionText "oi"
}
