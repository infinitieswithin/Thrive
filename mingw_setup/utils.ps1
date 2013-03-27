function Select-Directory {
    param(
        [string]$Title,
        [string]$Directory
    )
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.SelectedPath = $Directory
    $dialog.Description = $Title
    $dialog.ShowNewFolderButton = $TRUE
    $result = $dialog.ShowDialog()
    If ($result -eq "OK") {
        Return $dialog.SelectedPath
    }
    Else {
        Return $null
    }
}



function Unzip {
    param(
        [string]$filename,
        [string]$directory
    )
    $shell_app=new-object -com shell.application
    $archive = $shell_app.namespace($filename)
    $destination = $shell_app.namespace($directory)
    $destination.Copyhere($archive.items(), 0x14)
}