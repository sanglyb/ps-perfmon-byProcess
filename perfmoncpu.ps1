$date=get-date -format "dd-MM-yyyy HH-mm"
$cores=(Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
if (($cores -eq $null) -and ($env:computername -eq "DEVTFS03-MSC")){
	$cores = 2
}
$cpu=get-counter "\Process(*)\% Processor Time" -erroraction silentlycontinue -SampleInterval 1 -MaxSamples 10 | Select-Object -ExpandProperty CounterSamples | Group-Object -Property InstanceName | ForEach-Object { $_ | Select-Object -Property @{n="date";e={$date}},Name, @{n='CPU (AVG 10s)';e={[math]::Round((($_.Group.CookedValue | Measure-Object -Average).Average/$cores),2)}}} 
$cpu