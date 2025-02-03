#Creates the Inheritor Log if it does not exist
if (![System.Diagnostics.EventLog]::SourceExists('Inheritor Log')) {
    New-EventLog -LogName 'Inheritor Log' -Source 'Inheritor Monitoring'
}
#Creates the Inheritor Folder if it does not exist
if (!(Test-Path "C:\Inheritor")){
    New-Item -Path "C:\Inheritor" -Type Directory
}

#Creates Log that the script has started. Message needs to contian script name.
Write-EventLog -LogName 'Inheritor Log' -Source 'Inheritor Monitoring' -EventID 1 -Message "Script Has started" 

# ~Anything Above this line is the Script Template and may change~ #

