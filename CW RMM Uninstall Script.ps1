# Uninstall CW RMM
Write-Output ""
Write-Output "Beginning CW RMM Uninstall"

# Uninstall ITSPlatform
Write-Output "Triggering ITSPlatform uninstall"
Get-WmiObject -Class Win32_Product -Filter "Name='ITSPlatform'" | ForEach-Object { $_.Uninstall() }

# Run Uninstall.exe for SAAZOD
Write-Output "Triggering SAAZOD uninstall"
if (Test-Path -Path "C:\Program Files (x86)\SAAZOD\Uninstall\Uninstall.exe") {
	Start-Process -FilePath "C:\Program Files (x86)\SAAZOD\Uninstall\Uninstall.exe" -Wait -ArgumentList '/silent /u:"C:\Program Files (x86)\SAAZOD\Uninstall\Uninstall.xml"'
	Start-Sleep -s 10
}
else {
	Write-Output "WARNING: C:\Program Files (x86)\SAAZOD\Uninstall\Uninstall.exe does not exist"
}


# Stop and force close related processes
#Get-Process -Name 'platform-agent*', 'SAAZ*', 'rthlpdk' | Stop-Process -Force
Write-Output "Stopping CW RMM processes"
$CWRMMProcesses = @(
	'platform-agent*',
	'platform-*-plugin',
	'SAAZ*',
	'rthlpdk'
)

$ProcessesToStop = Get-Process -Name $CWRMMProcesses | Select-Object -ExpandProperty Name
forEach ($ProcessToStop in $ProcessesToStop) {
	if (Get-Process -Name "$ProcessToStop") {
		Write-Output "Stopping Process: $ProcessToStop"
		Get-Process -Name "$ProcessToStop" | Stop-Process -Force
	}
}

# Stop and force close related services
#Get-Service -Name 'ITSPlatform*', 'SAAZ*' | Stop-Service -Force
Write-Output "Stopping CW RMM services"
$CWRMMServices = @(
	'ITSPlatform*',
	'SAAZ*'
)

$ServicesToStop = Get-Service -Name $CWRMMServices | Select-Object -ExpandProperty Name
forEach ($ServiceToStop in $ServicesToStop) {
	if (Get-Service -Name "$ServiceToStop") {
		Write-Output "Stopping Service: $ServiceToStop"
		Get-Service -Name "$ServiceToStop" | Stop-Service -Force
	}
}

# Delete specified services
Write-Output "Deleting CW RMM services"
foreach ($service in $ServicesToStop) {
	#sc.exe delete $service
	Write-Output "Deleting service: $service"
	Start-Process -FilePath "sc.exe" -ArgumentList "delete", $service -NoNewWindow -Wait 
}

#Alternative service deletion
Get-CimInstance -ClassName win32_service | Where-Object { ($_.PathName -like 'ITSPlatform*') -or ($_.PathName -like 'SAAZ*') } | ForEach-Object { Invoke-CimMethod $_ -Name StopService; Remove-CimInstance $_ -Verbose -Confirm:$false }

# Delete specified folders
Write-Output "Deleting CW RMM related folders."
$FoldersToDelete = @(
	'C:\Program Files (x86)\ITSPlatformSetupLogs',
	'C:\Program Files (x86)\ITSPlatform',
	'C:\Program Files (x86)\SAAZOD',
	'C:\Program Files (x86)\SAAZODBKP',
	'C:\ProgramData\SAAZOD'
)

foreach ($folder in $FoldersToDelete) {
	if (Test-Path $folder) {
		Write-Output "Deleting folder: $folder"
		Get-ChildItem $folder -Recurse -Force | Remove-Item -Recurse -Force -Confirm:$false -Verbose
		Start-Sleep -Seconds 1
		Remove-Item -Path $folder -Recurse -Force -Confirm:$false -Verbose
	}
}


# Remove "C:\Program" file
Write-Output "Testing for rogue 'C:\Program' file"
if (Test-Path -LiteralPath "C:\Program" -PathType leaf) {
	Write-Output "Deleting rogue 'C:\Program' file"
	Remove-Item -LiteralPath "C:\Program" -Force -Confirm:$false -Verbose
}


# Remove registry keys
Write-Output "Deleting CW RMM registry keys"
$RegistryKeysToRemove = @(
	'HKLM:\SOFTWARE\WOW6432Node\SAAZOD',
	'HKLM:\SOFTWARE\WOW6432Node\ITSPlatform'    
)

foreach ($RegistryKey in $RegistryKeysToRemove) {
	if (Test-Path -LiteralPath $RegistryKey) {
		Write-Output "Deleting registry key: $RegistryKey"
		Remove-Item -Path $RegistryKey -Recurse -Force -Confirm:$false -Verbose
	}
}

# Remove the registry key with spaces
$BlankRegistryKey = "HKLM:\SOFTWARE\WOW6432Node\  \ITSPlatform"

# Test if the specific registry key exists
if (Test-Path -LiteralPath $BlankRegistryKey) {
	Write-Output "Deleting registry key: $BlankRegistryKey"

	# Get parent key's path
	$parentKey = Split-Path $BlankRegistryKey -Parent

	try {
		# Delete the parent key recursively
		Remove-Item -Path $parentKey -Recurse -Force -Confirm:$false -Verbose -ErrorAction Stop
		Write-Output "Parent registry key deleted successfully."
	}
	catch {
		Write-Output "Failed to delete parent registry key: $_"
	}
}
else {
	Write-Output "Blank registry key not found. Nothing to delete."
}



### Clean up installer registry keys

# Define the path to start the search
$startPath = 'HKLM:\SOFTWARE\Classes\Installer\Products\'

# Define the target product name
$targetProductName = 'ITSPlatform'

# Function to search for keys with the specified product name
function Find-RegistryKeys {
	param (
		[string]$Path
	)

	# Get all subkeys
	$subKeys = Get-ChildItem -Path $Path -ErrorAction SilentlyContinue

	# Loop through each subkey
	foreach ($subKey in $subKeys) {
		# Get the value of the productName property
		$productName = (Get-ItemProperty -Path $subKey.PSPath -Name 'productName' -ErrorAction SilentlyContinue).productName

		# Check if the productName matches the target product name
		if ($productName -eq $targetProductName) {
			# Output the path of the matching key
			#Write-Output $subKey.PSPath
			[PSCustomObject]@{
				Path = $subKey.PSPath
				ProductName = $productName
			}
		}

		# Search for matching keys in the current subkey
		Find-RegistryKeys -Path $subKey.PSPath
	}
}

# Start the search
$ProductRegistryKeysToRemove = Find-RegistryKeys -Path $startPath

# Delete the found keys
if ($ProductRegistryKeysToRemove) {
    foreach ($ProductRegistryKeyToRemove in $ProductRegistryKeysToRemove) {
        if (Test-Path -LiteralPath $ProductRegistryKeyToRemove.Path) {
            Write-Output "Deleting registry key: $($ProductRegistryKeyToRemove.Path)"
            Remove-Item -Path $ProductRegistryKeyToRemove.Path -Recurse -Force -Confirm:$false -Verbose
        }
    }
}

Write-Output "Done! CW RMM should be successfully uninstalled and remnants removed"
