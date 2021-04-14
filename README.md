# ps-perfmon-byProcess
powershell script to get memory and cpu stats consumed by processes, and write result to csv files.
CPU statistics - is average value for 10 seconds. 
Memory statistics - is momental value, when script is running.
There are 4 scripts:
- perfomncpu.ps1, permonmem.ps1 and runscript.ps1 are used to get statistics from remote computers via invoke-command in runscript.ps1. List of servers is set in servers.txt.
- perfomn-single - can be run directly on needed computer, if for example for some reason there is no remote access with powershell to it. 

You need to set $path and $csvPath variables in scripts - $path is path to folder where you downloaded scripts. $csvPath - is location for csv files. 


