$path="C:\Users\user\Documents\git\ps-perfmon"
$csvPath="\\server\statistics\"
$servers=get-content "$path\servers.txt"
foreach ($server in $servers){
	$filenamemem=$csvPath+$server+"-mem.csv"
	$resultmem=$null
	$contentmem=$null
	$contentmem=import-csv $filenamemem
	$resultmem=invoke-command -computername $server -filepath "$path\perfmonmem.ps1" 
	if ($resultmem -ne $null){
		$contentmem += $resultmem
		$contentmem | export-csv $filenamemem
	}
	$filenamecpu=$csvPath+$server+"-cpu.csv"
	$resultcpu=$null
	$contentcpu=$null
	$contentcpu=import-csv $filenamecpu
	$resultcpu=invoke-command -computername $server -filepath "$path\perfmoncpu.ps1" 
	if ($resultcpu -ne $null){
		$contentcpu += $resultcpu
		$contentcpu | export-csv $filenamecpu
	}
}