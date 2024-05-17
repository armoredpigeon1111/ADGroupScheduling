# ADGroupScheduling
PowerShell Script to schedule adding and removing Active Directory Groups


To make use of ADGroupScheduling:

1) Copy files to a network location.

2) Edit the ADGroupScheduling.ps1 and ADGroupRunJob.ps1 files to set the file path to the ADGroupScheduling.json file and set your Active Directory Group.

3) On a network connected computer (that will be on at the time you want to run the job) use Windows Task Scheduler to create a task that runs the ADGroupRunJob.ps1 at the desired time and interval. Make sure you are running the script with highest privileges and whether user is logged on or not. (These are settings on the General tab of Create a Task. 

4) When you are ready to add a user run the AdGroupScheduling.ps1 as administrator and fill in the prompts for the Active Directory Username, Start Date, and End Date.

5) Enjoy!

***If the start date is the current date the group will be added immediately.

***On the end date the JSON entry will be deleted.
