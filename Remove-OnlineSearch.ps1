#Requires -RunAsAdministrator

Param (
  [Parameter(mandatory=$false)][switch]$RestartExplorer,
  [Parameter(mandatory=$false)][switch]$EnableSearch
)

$RegPath  = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
$RegDword = 'DisableSearchBoxSuggestions'
$RegValue = 1

if (!$EnableSearch) {
  New-Item -Path $RegPath -Force | New-ItemProperty -Name $RegDword -Value $RegValue -Force | Out-Null
}
else {
  Remove-ItemProperty -Path $RegPath -Name $RegDword -ErrorAction SilentlyContinue
}

if ($RestartExplorer) {
  Stop-Process -ProcessName explorer
}
