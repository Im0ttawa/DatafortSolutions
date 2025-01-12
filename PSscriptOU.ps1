Import-Module ActiveDirectory

$orgunit = Import-Csv -Path "C:\Users\Administrator\Desktop\oui.csv"

$orgunit | Write-Host

$orgunit | ForEach-Object {

$Name = $_.Name `

New-ADOrganizationalUnit -Name $Name -Path "DC=gruta,DC=local"

}

$users = Import-Csv -Path "C:\Users\Administrator\Desktop\lista.csv"

$users | ForEach-Object {

    $FirstName = $_.FirstName
    $LastName = $_.LastName
    $UserName = $_.UserName
    $Department = $_.Department
    $Password = ConvertTo-SecureString $_.Password -AsPlainText -Force
    $OU = "OU=$Department,DC=gruta,DC=local"

New-ADUser `
        -SamAccountName $UserName `
        -UserPrincipalName "$UserName@gruta.com" `
        -Name "$FirstName $LastName" `
        -GivenName $FirstName `
        -Surname $LastName `
        -DisplayName "$FirstName $LastName" `
        -Department $Department `
        -AccountPassword $Password `
        -ChangePasswordAtLogon $true `
        -Enabled $true `
        -Path $OU `
        -PassThru
}