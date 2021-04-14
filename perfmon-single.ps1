$date=get-date -format "dd-MM-yyyy HH-mm"
$path="C:\Users\user\Documents\git\ps-perfmon"
$csvPath="\\server\statistics\"
$memfilename=$csvPath+$env:COMPUTERNAME+"-mem.csv"
$cpufilename=$csvPath+$env:COMPUTERNAME+"-cpu.csv"
$properties=@(
	@{n="date";e={$date}},
	@{Name="PName"; Expression = {$_.name}},
	@{Name="Memory(MB)"; Expression = {[Math]::Round(($_.workingSetPrivate / 1mb),2)}}
)
$cores=(Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
$mem=$null
$cpu=$null
$mem=Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | Select-Object $properties |Sort-Object -property "Memory (MB)" -Descending 
$cpu=get-counter "\Process(*)\% Processor Time" -erroraction silentlycontinue -SampleInterval 1 -MaxSamples 10 | Select-Object -ExpandProperty CounterSamples | Group-Object -Property InstanceName | ForEach-Object { $_ | Select-Object -Property @{n="date";e={$date}},Name, @{n='CPU (AVG 10s)';e={[math]::Round((($_.Group.CookedValue | Measure-Object -Average).Average/$cores),2)}}} 
$contentmem=$null
$contentmem=import-csv $memfilename
	if ($mem -ne $null){
		$contentmem += $mem
		$contentmem | export-csv $memfilename
	}
$contentcpu=$null	
$contentcpu=import-csv $cpufilename
	if ($cpu -ne $null){
		$contentcpu += $cpu
		$contentcpu | export-csv $cpufilename
	}


