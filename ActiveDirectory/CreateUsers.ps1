<#

.DESCRIPTION
Script to create Active Directory accounts

.NOTES
NateV, May 2019 - I don't think we use this anymore,
v2 9/12/2012
Todd Klindt
http://www.toddklindt.com

#>


param(
    [string]$DefaultPassword = $(throw "Provide a default random password for these new accounts.")
)

# Add the Active Directory bits and not complain if they're already there
Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# set default password
$defpassword = (ConvertTo-SecureString $DefaultPassword -AsPlainText -force)

# Get domain DNS suffix
$dnsroot = '@' + (Get-ADDomain).dnsroot

# Import the file with the users. You can change the filename to reflect your file
$users = Import-Csv .\users.csv

foreach ($user in $users) {
        if ($user.manager -eq "") # In case it's a service account or a boss
            {
                try {
                    New-ADUser -SamAccountName $user.SamAccountName -Name ($user.FirstName + " " + $user.LastName) `
                    -DisplayName ($user.FirstName + " " + $user.LastName) -GivenName $user.FirstName -Surname $user.LastName `
                    -UserPrincipalName ($user.SamAccountName + $dnsroot) `
                    -Description $user.Description -HomeDirectory $user.HomeDirectory -HomeDrive $user.HomeDrive `
                    -ScriptPath $user.ScriptPath -Path $user.Path `
                    -AccountExpirationDate $user.AccountExpirationDate `
                    -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires  $false `
                    -AccountPassword $defpassword -PassThru `
                    
                    }
                catch [System.Object]
                    {
                        Write-Output "Could not create user $($user.SamAccountName), $_"
                    }
            }
            else
             {
                try {
                 #   New-ADUser -SamAccountName $user.SamAccountName -Name ($user.FirstName + " " + $user.LastName) `
                 #   -DisplayName ($user.FirstName + " " + $user.LastName) -GivenName $user.FirstName -Surname $user.LastName `
                 #   -UserPrincipalName ($user.SamAccountName + $dnsroot) `
                 #   -Title $user.title -manager $user.manager `
                 #   -Description $user.Description -HomeDirectory $user.HomeDirectory -HomeDrive $user.HomeDrive `
                 #   -ScriptPath $user.ScriptPath -Path $user.Path `
                 #   -AccountExpirationDate $user.AccountExpirationDate `
                 #   -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires  $false `
                 #   -AccountPassword $defpassword -PassThru `
                    }
                catch [System.Object]
                    {
                        Write-Output "Could not create user $($user.SamAccountName), $_"
                    }
             }
        # Put picture part here.
   #     $filename = "$($user.SamAccountName).jpg"
   #     Write-Output $filename

   #     if (test-path -path $filename)
   #         {
   #             Write-Output "Found picture for $($user.SamAccountName)"

   #            $photo = [byte[]](Get-Content $filename -Encoding byte)
   #            Set-ADUser $($user.SamAccountName) -Replace @{thumbnailPhoto=$photo} 
   #         }
   }

