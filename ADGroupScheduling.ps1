#ADGroupScheduling.ps1
#Author: Richard Fleming
#ArmoredPigeon1111
#May 17, 2024

#Setting the variables to desired values
$CurrentDate = Get-Date -Format "yyyy-MM-dd"
$User = Read-Host -Prompt "What is the username you wish to grant VPN access to?"
$StartDate = Read-Host -Prompt "What date would you like access to start? (yyyy-MM-dd)"
$EndDate = Read-Host -Prompt "What date would you like access to end? (yyyy-MM-dd)"
$FilePath = "***ENTER YOUR FILE PATH to ADGroupScheduling.json HERE***" 

#Adds Firm-VPN Active Directory Group to the specified user.
function Add-ADGroup{
    Add-ADGroupMember -Identity "***ENTER YOUR ACTIVE DIRECTORY GROUP HERE" -Members $User
}

#Retrieves JSON file and converts it to PowerShell Object
function Get-JSONFile{
    $JSONData = Get-Content -Path $FilePath -Encoding UTF8 | ConvertFrom-JSON -ErrorAction STOP
    return $JSONData
}

#Adds User, Start Date and End Date JSON Entry
function Add-JSONEntry {
    $HashTable = [ordered] @{"Username" = $User; "StartDate" = $StartDate; "EndDate" = $EndDate}
    $JSONData = Get-JSONFile
    $Asset = New-Object -TYPEName PSObject
    $Asset | Add-Member $HashTable -TYPEName 'Asset'
    $JSONData += $Asset
    $JSONData | ConvertTo-JSON | Set-Content -Path $FilePath
}

#Start of program
if($StartDate -eq $CurrentDate){
    Add-ADGroup
    Add-JSONEntry
}else{
    Add-JSONEntry
}

#Prints existing list for confirmation
$Confirmation = Get-JSONFile
$Confirmation | Out-Host

#Stops the PowerShell window from closing automatically so you can verify
Read-Host -Prompt "Press Enter to Exit"