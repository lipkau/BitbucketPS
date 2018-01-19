function Get-Repository {
    [CmdletBinding( SupportsPaging )]
    # [OutputType([BitbucketPS.Repository])]
    Param (
        [Parameter( Mandatory )]
        [String]
        $ServerName,

        [String[]]
        $Repository,

        [switch]
        $ExcludePersonalProjects,

        # Maximum number of results to fetch per call.
        # This setting can be tuned to get better performance according to the load on the server.
        #
        # Warning: too high of a PageSize can cause a timeout on the request.
        [ValidateRange(1, [Int]::MaxValue)]
        [Int]
        $PageSize = 25,

        # Credentials to use to connect to Server.
        # If not specified, this function will use anonymous access.
        [PSCredential]
        $Credential
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $resourceURi = "/repos"
    }

    process {
        Write-DebugMessage "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
        Write-DebugMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"

        # foreach ($_repository in $Repository) {
        # Write-Verbose "[$($MyInvocation.MyCommand.Name)] Processing [$_repository]"
        # Write-Debug "[$($MyInvocation.MyCommand.Name)] Processing `$_repository [$_repository]"

        $parameter = @{
            Uri           = $resourceURi
            ServerName      = $ServerName
            Method        = "Get"
            GetParameters = @{
                limit = $PageSize
            }
            # OutputType    = [BitbucketPS.Repository]
            Credential    = $Credential
        }

        # Paging
        if ($PSCmdlet.PagingParameters) {
            ($PSCmdlet.PagingParameters | Get-Member -MemberType Property).Name | ForEach-Object {
                $parameter[$_] = $PSCmdlet.PagingParameters.$_
            }
        }

        Write-Debug "[$($MyInvocation.MyCommand.Name)] Calling Invoke-Method with `$parameter"
        Invoke-Method @parameter
        # }
    }


    # $RepoObj | Select slug,
    #             Name,
    #             State,
    #             StatusMessage,
    #             Forkable,
    #             @{Name="Project";Expression={ $_.project.key }},
    #             @{Name="ProjectName";Expression={ $_.project.name }},
    #             Public,
    #             @{Name="CloneLinks";Expression={ $_.links.clone }},
    #             @{Name="URL";Expression={ $_.links.self.href }}
}
