Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'

[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$JournalCleaner = New-Object system.Windows.Forms.Form
$JournalCleaner.ClientSize = New-Object System.Drawing.Point(338, 158)
$JournalCleaner.text = "JournalCleaner"
$JournalCleaner.TopMost = $false
$JournalCleaner.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282727")

$ToolTip1 = New-Object system.Windows.Forms.ToolTip

$ComboBox1 = New-Object system.Windows.Forms.ComboBox
$ComboBox1.text = "Please choose a drive to clean the NTFS Journals"
$ComboBox1.width = 320
$ComboBox1.height = 150
$ComboBox1.location = New-Object System.Drawing.Point(9, 9)
$ComboBox1.Font = New-Object System.Drawing.Font('HP Simplified', 10)
$ComboBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$ComboBox1.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282727")

$Button1 = New-Object system.Windows.Forms.Button
$Button1.text = "Clean"
$Button1.width = 320
$Button1.height = 110
$Button1.location = New-Object System.Drawing.Point(9, 37)
$Button1.Font = New-Object System.Drawing.Font('HP Simplified', 35)
$Button1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$JournalCleaner.controls.AddRange(@($ComboBox1, $Button1))

$drives = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object { $_.DeviceID + " - " + $_.VolumeName }
$ComboBox1.Items.AddRange($drives)

$Button1.Add_Click({
    $selectedDrive = ($ComboBox1.SelectedItem -split ' - ')[0]
    if ($selectedDrive -eq $null) {
        [System.Windows.Forms.MessageBox]::Show("Please choose a drive before clicking the Clean button.")
        return
    }

    $output = fsutil usn deletejournal /d /n $selectedDrive 2>&1
    if ($LASTEXITCODE -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("The NTFS Journals on drive $selectedDrive were cleaned successfully.")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Failed to clean the NTFS Journals on drive $selectedDrive.`nReason: $output")
    }
})

[void]$JournalCleaner.ShowDialog()
