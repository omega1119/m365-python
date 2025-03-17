# Define parameters
$AppName = "M365GraphAPIApp"

# Check if already logged in
$LoggedIn = az account show --query "id" -o tsv 2>$null
if (-not $LoggedIn) {
    Write-Output "Not logged in. Running az login..."
    az login
} else {
    Write-Output "Already logged in."
}

# Get Tenant ID from Azure CLI
$TenantId = az account show --query "tenantId" -o tsv
Write-Output "Tenant ID: $TenantId"

# Check if the app already exists
$ExistingAppId = az ad app list --filter "displayName eq '$AppName'" --query "[0].appId" -o tsv
if ($ExistingAppId) {
    Write-Output "Application already exists with App ID: $ExistingAppId"
    $AppId = $ExistingAppId
} else {
    # Create the App Registration
    $AppId = az ad app create --display-name $AppName --query appId -o tsv
    Write-Output "New App ID: $AppId"
}

# Check if a client secret exists
$ExistingSecretId = az ad app credential list --id $AppId --query "[0].keyId" -o tsv

if ($ExistingSecretId) {
    Write-Output "Existing secret found. Recycling..."
    az ad app credential delete --id $AppId --key-id $ExistingSecretId
}

# Create a new Client Secret
$ClientSecret = az ad app credential reset --id $AppId --query password -o tsv
Write-Output "New Client Secret: $ClientSecret"

# Assign API Permissions (User.Read.All and Directory.Read.All for Graph API)
# https://learn.microsoft.com/en-us/graph/permissions-reference
# User.Read.All
az ad app permission add --id $AppId --api 00000003-0000-0000-c000-000000000000 --api-permissions df021288-bdef-4463-88db-98f22de89214=Role
# Directory.Read.All
az ad app permission add --id $AppId --api 00000003-0000-0000-c000-000000000000 --api-permissions 7ab1d382-f21e-4acd-a863-ba3e13f7da61=Role

# Grant admin consent
az ad app permission admin-consent --id $AppId

# Explicitly grant permissions to make them effective
az ad app permission grant --id $AppId --api 00000003-0000-0000-c000-000000000000 --scope User.Read.All 
az ad app permission grant --id $AppId --api 00000003-0000-0000-c000-000000000000 --scope Directory.Read.All

# Check if the service principal exists
$ExistingSPId = az ad sp list --filter "appId eq '$AppId'" --query "[0].id" -o tsv
if (!$ExistingSPId) {
    # Create a Service Principal if it doesn't exist
    az ad sp create --id $AppId
}

# Save credentials to a file for use in the Jupyter Notebook
$Config = @{
    "tenant_id" = "$TenantId"
    "client_id" = "$AppId"
    "client_secret" = "$ClientSecret"
}
$Config | ConvertTo-Json | Set-Content -Path "./config.json"
Write-Output "Configuration saved to config.json"

# Output the required details
Write-Output "Application registration process completed successfully!"
Write-Output "App ID: $AppId"
Write-Output "New Client Secret: $ClientSecret"
Write-Output "Tenant ID: $TenantId"
