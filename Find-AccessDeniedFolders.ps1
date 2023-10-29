
<#
.SYNOPSIS
    Recursively searches for folders starting from a specified root directory and identifies those with "Access Denied" errors.

.PARAMETER path
    Specifies the directory path where the search will begin.
    [ValidateScript: Must be a valid path]
    [Default: None]

.PARAMETER exclude
    Specifies an array of directory paths to be excluded from the search.
    [Default: None]

.EXAMPLE
    Find-AccessDeniedFolders -path "W:\" -exclude @("W:\System Volume Information", "W:\$RECYCLE.BIN")
    This example starts the search from the "W:\" directory, excludes specified directories, and lists folders where access is denied.

.NOTES
    - The function uses Get-ChildItem to traverse the directory structure.
    - It employs a try-catch block to capture "Access Denied" errors and other unexpected errors.
    - The function writes the paths with "Access Denied" errors to the standard output.
    - Directory exclusions are handled using the Where-Object cmdlet to filter out specified directories.
#>


# Function to recursively find folders with access denied errors
function Find-AccessDeniedFolders {
    param (
        [ValidateScript({Test-Path $_})]
        [string]$path=$null,
        [string[]]$exclude=$null
    )

    try {
        # Try to get the child items in the current directory
        $items = Get-ChildItem -Directory -Path $path -ErrorAction Stop | Where-Object { $_.FullName -notin $exclude }

        foreach ($item in $items) {
            # Continue recursively searching in subdirectories
            Find-AccessDeniedFolders -path $item.FullName -exclude $exclude
        }
    }
    catch {
        # Check if the error message contains "Access to the path is denied"
        if ($_ -match "Access to the path '(.+)' is denied.") {
            $accessDeniedPath = $matches[1]
            Write-Output $accessDeniedPath
        }
        else {
            Write-Host "An unexpected error occurred: $_"
        }
    }
}

# Define the root directory to start the search
#$rootDirectory = "W:\"
#$excludedDirectories = @("W:\System Volume Information", "W:\$RECYCLE.BIN")  # Add directories to be excluded

# Start the search from the root directory
#Find-AccessDeniedFolders -path $rootDirectory -exclude $excludedDirectories
