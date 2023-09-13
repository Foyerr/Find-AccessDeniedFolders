# Define the root directory to start the search
$rootDirectory = "W:\"

# Function to recursively find folders with access denied errors
function Find-AccessDeniedFolders {
    param (
        [string]$path
    )

    try {
        # Try to get the child items in the current directory
        $items = Get-ChildItem -Directory -Path $path -ErrorAction Stop

        foreach ($item in $items) {
            # Check if the item is a directory (folder)
           
            # Continue recursively searching in subdirectories
            Find-AccessDeniedFolders -path $item.FullName
           
        }
    }
    catch {
        # Check if the error message contains "Access to the path is denied"
        if ($_ -match "Access to the path '(.+)' is denied.") {
            $accessDeniedPath = $matches[1]
            
            #Show that the SID for depracatied group is assigned to directory
            #Get-Acl $accessDeniedPath | select AccessToString 
            
            Write-Output $accessDeniedPath #| Out-File -Append -FilePath $accessDeniedFoldersFile
        }
    }
}

# Start the search from the root directory
Find-AccessDeniedFolders -path $rootDirectory

Write-Host "Search completed. Folders with access denied errors are listed in $accessDeniedFoldersFile."
