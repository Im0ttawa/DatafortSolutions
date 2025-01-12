$subnet = "192.168.1"
$range = 1..255

foreach ($i in $range) {
    $ip = $subnet + "." + $i
    if (Test-Connection -ComputerName $ip -Count 1 `
        -Quiet) {
            Write-Host "$ip is up"
     }
   }