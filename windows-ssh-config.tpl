add-content -path c:/users/Raja/.ssh/config value @'


Host ${hostname}
  HostName ${hostname}
  User ${user}
  IdentityFile ${identityfile}
'@