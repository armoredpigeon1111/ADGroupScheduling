#ADGroupRunJob.ps1
#Author: Richard Fleming
#Armoredpigeon1111
#May 17, 2024


$FilePath = "***ENTER YOUR FILE PATH TO ADGroupScheduling.json"
$CurrentDate = Get-Date -Format "yyyy-MM-dd"

#Adds Active Directory Group Firm-VPN to User 
function Add-ADGroup($User){
    Add-ADGroupMember -Identity "***ENTER YOUR ACTIVE DIRECTORY GROUP***" -Members $User
    Write-Output "Successfully Added $User"
}

#Removes Active Directory Group Firm-VPN from User
function Remove-ADGroup($User){
    Remove-ADGroupMember -Identity "***ENTER YOUR ACTIVE DIRECTORY GROUP***" -Members $User -Confirm:$False
    Write-Output "Removed $User"
}

#Retrieves JSON File with User Start and End Dates and Converts it to usable format
function Get-JSONFile{
    $JSONData = Get-Content -Path $FilePath -Encoding UTF8 | ConvertFrom-JSON -ErrorAction STOP
    return $JSONData
}

#Finds Users with Matching VPN Start Date
function Find-UsersToAdd {
    $JSONData = Get-JSONFile
    $Users = $JSONData | Where {$_.StartDate -eq $CurrentDate}
    foreach ($User in $Users){ Add-ADGroup $User.Username}
}

#Finds Users with Matching VPN End Date
function Find-UsersToRemove{
    $JSONData = Get-JSONFile
    $Users = $JSONData | Where {$_.EndDate -eq $CurrentDate}
    foreach ($User in $Users){ 
        Remove-ADGroup $User.Username
        #Add Deletion from JSON
        $JSONData = $JSONData | Where-Object {$_.Username -NotLike $User.Username}
        $JSONData | ConvertTo-JSON | Set-Content -Path $FilePath
    }

}

#Start of Program
Find-UsersToAdd
Find-UsersToRemove

Read-Host -Prompt "Press Enter to Exit"
