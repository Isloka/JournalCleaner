# JournalCleaner

**JournalCleaner** is a PowerShell tool designed to clear NTFS Journals on Windows systems.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)

## Introduction

The NTFS Journal is a feature in Windows that records changes to files and directories on an NTFS file system. 
Over time, the journal can grow in size and might need to be cleared to free up disk space. 
**JournalCleaner** is a simple utility written in PowerShell to help you clean the NTFS Journals on specific drives.

## Features

- List all current drives available on the computer.
- Choose a drive and clean its NTFS Journal.
- Provides feedback on the success or failure of the cleaning operation.

## Requirements

- Windows operating system.
- PowerShell (usually pre-installed on Windows systems).

## Usage

1. Clone or download the repository to your local machine.

2. Launch the `JournalCleaner.ps1` script using PowerShell.

3. The GUI will open, displaying a ComboBox with a list of current drives. Select the drive you want to clean.

4. Click the "Clean" button to initiate the cleaning process.

5. If the cleaning operation is successful, you will receive a confirmation message. Otherwise, an error message will indicate the reason for the failure.

## Contributing

I welcome any contributions from the community. 
If you find any issues or have suggestions for improvements, feel free to create a pull request or open an issue.

## Disclaimer

The tool modifies the NTFS Journal, which can impact file system behavior. Use this tool at your own risk. Always back up your important data before making any changes to the file system.
