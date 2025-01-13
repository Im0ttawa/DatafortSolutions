function UserInfo {
    $username = Read-Host "Please insert account username"
    Write-Host "Getting $username information, please wait..."
    Start-Sleep -Seconds 4

    $user = Get-ADUser  -Identity $username -Properties SamAccountName, Name, Department, PrimaryGroup
    if ($user) {
        $user | Format-Table SamAccountName, Name, Department, PrimaryGroup
    } else {
        Write-Host "User  $username not found." -ForegroundColor Red
        Start-Sleep -Seconds 1
        Write-Host "Returning to the Menu..."
    }
    Start-Sleep -Seconds 2
}

function UserLookupMenu {
    $userInput = 0
    while ($userInput -ne 3) {

        Write-Host "|==============================================|"
        Write-Host "|            User Lookup Menu                  |"
        Write-Host "|==============================================|"
        Write-Host "|                                              |"
        Write-Host "|1.....Get User information with username      |"
        Write-Host "|                                              |"
        Write-Host "|2.....Get User list of a specific Department  |"
        Write-Host "|                                              |"
        Write-Host "|3.....Return to Main Menu                     |"
        Write-Host "|                                              |"
        Write-Host "|==============================================|"
        echo ""
        $userInput = Read-Host "Please choose an option"

        if ($userInput -eq 1) {
            UserInfo
        } elseif ($userInput -eq 2) {
            #FALTA USER BY DEPARTMENT
            Write-Host "This feature is not yet implemented." -ForegroundColor Yellow
        } elseif ($userInput -eq 3) {
            Write-Host "Returning to Main Menu..." -ForegroundColor Green
        } else {
            Write-Host "Invalid option, please try again." -ForegroundColor Red
        }
    }
}

function NetScan {
    $date = (Get-Date).ToString("yyyy/MM/dd HH:mm:ss")
    $subnet = "192.168.1"
    $range = 1..10
    $ipList = @()

    foreach ($i in $range) {
        $ip = "$subnet.$i"
        $ping = Test-Connection -ComputerName $ip -Count 1 -Quiet

        if ($ping) {
            Write-Host "$ip is UP" -ForegroundColor Green
            $ipList += "$date $ip is UP"

        } else {
            Write-Host "$ip is DOWN" -ForegroundColor Red
            $ipList += "$date $ip is DOWN"
        }
    }

    $logPath = "C:\Users\Administrator\Desktop\logs\NetScan.log"
    Add-Content -Path $logPath -Value "`n === NEW LOG ENTRY $date === `n"
    $ipList | Out-File -Append -FilePath $logPath
    Write-Host "A new log entry was added to the log file @ $logPath `n" -BackgroundColor Black -ForegroundColor White

    Start-Sleep -Seconds 5
}

function Menu {
    $userInput = 0
    while ($userInput -ne 3) {

        Write-Host "|=======================================|"
        Write-Host "|Welcome to the Network Management tool!|"
        Write-Host "|=======================================|"
        Write-Host "|                                       |"
        Write-Host "|1.....Network Scan                     |"
        Write-Host "|                                       |"
        Write-Host "|2.....User  Lookup                     |"
        Write-Host "|                                       |"
        Write-Host "|3.....EXIT                             |"
        Write-Host "|                                       |"
        Write-Host "|=======================================|"
        $userInput = Read-Host "Please choose an option"

        if ($userInput -eq 1) {
            NetScan

        } elseif ($userInput -eq 2) {
            UserLookupMenu

        } elseif ($userInput -eq 3) {
            Write-Host "Exiting the program..." -ForegroundColor Green

        } else {
            Write-Host "Invalid option, please try again." -ForegroundColor Red
        }
    }
}
Menu