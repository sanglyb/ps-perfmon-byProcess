$date=get-date -format "dd-MM-yyyy HH-mm"
$properties=@(
	@{Name="Date"; Expression = {$date}},
    @{Name="Process Name"; Expression = {$_.name}},  
    @{Name="Memory(MB)"; Expression = {[Math]::Round(($_.workingSetPrivate / 1mb),2)}}
)
$result=Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | Select-Object $properties |Sort-Object -property "Memory (MB)" -Descending 
$result