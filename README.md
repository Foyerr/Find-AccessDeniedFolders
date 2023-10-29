# Find-AccessDeniedFolders PowerShell Function

## Overview

The `Find-AccessDeniedFolders` function is a PowerShell script designed to recursively search for folders starting from a specified root directory and identify those with "Access Denied" errors. This function is particularly useful for system administrators and IT professionals who need to audit folder permissions.

## Features

- Recursively searches through directories.
- Identifies folders with "Access Denied" errors.
- Provides an option to exclude specific directories from the search.
- Outputs the list of folders with access issues to the standard output.
- Handles unexpected errors gracefully.

## Requirements

- Windows PowerShell 5.1 or higher
- Administrative privileges for accurate results

## Parameters

- `path`: Specifies the directory path where the search will begin. Must be a valid path. Default is `null`.
- `exclude`: Specifies an array of directory paths to be excluded from the search. Default is `null`.

## Usage

### Basic Usage

#### Search

To start the search from the `W:\` directory:

```
Find-AccessDeniedFolders -path "W:\\"
```
#### Exclusions
Find-AccessDeniedFolders -path "W:\\" -exclude @("W:\\System Volume Information", "W:\\$RECYCLE.BIN")



