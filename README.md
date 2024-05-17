# ADGroupScheduling
PowerShell Script to schedule adding and removing Active Directory Groups


To make use of ADGroupScheduling:

1) Copy files to a network location.

2) Edit the ADGroupScheduling.ps1 and ADGroupRunJob.ps1 files to set the file path to the ADGroupScheduling.json file and set your Active Directory Group.

3) On a network connected computer (that will be on at the time you want to run the job) use Windows Task Scheduler to create a task that runs the ADGroupRunJob.ps1 at the desired time and interval. 
