# -------------------------------
# Parameters - Update these as needed
# -------------------------------
$appName = "GraphAPIExampleApp"
$yearsValid = 1                                # Client secret valid for 1 year

# -------------------------------
# Step 0: Retrieve and Output Tenant ID
# -------------------------------
Write-Output "Retrieving Tenant ID..."
$tenantId = az account show --query tenantId --output json | ConvertFrom-Json
if ([string]::IsNullOrEmpty($tenantId)) {
    Write-Output "Error retrieving Tenant ID. Ensure you are logged in with 'az login'."
    exit 1
}
Write-Output "Tenant ID: $tenantId"

# -------------------------------
# Step 1: Create the App Registration
# -------------------------------
Write-Output "Creating app registration..."
$appJson = az ad app create `
    --display-name $appName `
    --output json | ConvertFrom-Json

$appId = $appJson.appId
$appObjectId = $appJson.objectId

Write-Output "App created."
Write-Output "App ID: $appId"
Write-Output "Object ID: $appObjectId"

# -------------------------------
# Step 2: Check for or Create a Service Principal for the App
# -------------------------------
Write-Output "Checking for existing Service Principal..."
$spId = $null
try {
    $spObjectId = az ad sp show --id $appId --output json | ConvertFrom-Json
    if ($spObjectId) {
        Write-Output "Service Principal already exists with Object ID: $spObjectId"
        
    }
    else {
        Write-Output "No existing Service Principal found. Creating one..."
        $spObjectId = az ad sp create --id $appId --output json | ConvertFrom-Json
        Write-Output "Created Service Principal with Object ID: $spObjectId"
    }
    $spId = $spObjectId.id
}
catch {
    Write-Output "Error checking for Service Principal. Creating a new one..."
    $spObjectId = az ad sp create --id $appId --output json | ConvertFrom-Json
    Write-Output "Created Service Principal with Object ID: $spObjectId"
}

# -------------------------------
# Step 3: Create a Client Secret
# -------------------------------
Write-Output "Creating client secret..."
$secretJson = az ad app credential reset `
    --id $appId `
    --append `
    --years $yearsValid `
    --query "{clientSecret: password}" `
    --output json | ConvertFrom-Json

$clientSecret = $secretJson.clientSecret

Write-Output "Client secret created."
Write-Output "Client Secret: $clientSecret"
Write-Output "Make sure to store this secret securely. It will not be displayed again."

# -------------------------------
# Step 4: Add Microsoft Graph API Permissions
# -------------------------------
Write-Output "Adding Microsoft Graph API permissions..."
# Microsoft Graph resource ID
$graphResourceId = "00000003-0000-0000-c000-000000000000"
# Delegated permission IDs for Microsoft Graph:
#   User.Read: e1fe6dd8-ba31-4d61-89e7-88639da4683d
#   User.Read.All: df021288-bdef-4463-88db-98f22de89214
az ad app permission add --id $appId --api $graphResourceId --api-permissions "df021288-bdef-4463-88db-98f22de89214=Scope"

Write-Output "Permissions added."

# -------------------------------
# Step 5: Grant Admin Consent (Optional)
# -------------------------------
Write-Output "To grant admin consent for these permissions, run:"
Write-Output "az ad app permission admin-consent --id $appId"

# -------------------------------
# Summary Output
# -------------------------------
Write-Output "-------------------------------"
Write-Output "App Registration Setup Complete"
Write-Output "App Name: $appName"
Write-Output "App ID: $appId"
Write-Output "Service Principal ID: $spId"
Write-Output "Client Secret: $clientSecret"
Write-Output "  Tenant ID: $tenantId"
Write-Output "-------------------------------"