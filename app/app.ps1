 #inside this file put this content which is going to install iis 
# Ensure PowerShell is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run with Administrator privileges. Please restart PowerShell as Administrator and try again."
    exit 1
}

# Define the IIS features to install
# You can customize this list based on your specific application requirements
$iisFeatures = @(
    "IIS-WebServerRole",
    "IIS-ManagementConsole",
    "IIS-WebServer",
    "IIS-CommonHttpFeatures",
    "IIS-StaticContent",
    "IIS-DefaultDocument",
    "IIS-HttpErrors",
    "IIS-HttpRedirect",
    "IIS-ApplicationDevelopment",
    "IIS-ASPNET45", # For .NET 4.5/4.8 applications
    "IIS-NetFxExtensibility45", # For .NET 4.5/4.8 extensibility
    "IIS-ISAPIExtensions",
    "IIS-ISAPIFilter",
    "IIS-Security",
    "IIS-WindowsAuthentication",
    "IIS-RequestFiltering",
    "IIS-ManagementTools",
    "IIS-ManagementService"
)

Write-Host "Starting IIS feature installation..."

foreach ($feature in $iisFeatures) {
    Write-Host "Attempting to enable feature: $feature"
    try {
        Enable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
        Write-Host "Successfully enabled feature: $feature"
    } catch {
        Write-Warning "Failed to enable feature: $feature. Error: $($_.Exception.Message)"
    }
}

Write-Host "IIS feature installation complete. A restart may be required for all changes to take effect."
