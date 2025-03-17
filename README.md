# Microsoft 365 Graph API - App Registration & Python Example

## Overview
This project contains:
- A **PowerShell script** (`setup-appregistration.ps1`) to automate **Azure App Registration** using **Azure CLI**.
- A **Jupyter Notebook (`graph_api_example.ipynb`)** to authenticate and fetch Microsoft 365 Graph API data.

---

## Prerequisites
### Required Tools
- **Azure CLI** installed ([Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli))
- **Python 3.x** installed ([Download Python](https://www.python.org/downloads/))
- **Required Python packages**:
  ```bash
  pip install requests matplotlib
  ```

### Azure Requirements
- **Access to an Azure Subscription** with permissions to create app registrations.
- **Global Admin or Application Administrator** role to grant Graph API permissions.

---

## Setup & Run the PowerShell Script
### 1. Configure Azure App Registration
1. Open **PowerShell** and log in to Azure:
   ```powershell
   ./setup-appregistration.ps1
   ```
   This will:
   - Register a new Azure AD App.
   - Create a **Client Secret** (recycling it if one exists).
   - Assign **Graph API permissions** (`User.Read.All`, `Directory.Read.All`).
   - Grant **Admin Consent**.
   - Create a **Service Principal**.

2. Copy the output values:
   - **App ID**
   - **Client Secret**
   - **Tenant ID**

3. A file called `config.json` will be created with these credentials for use in the Jupyter Notebook.

---

## Run the Jupyter Notebook
### 1. Open `graph_api_example.ipynb`
1. **Ensure `config.json` exists** in the working directory.
2. Open the notebook and edit these variables:
   ```python
   TENANT_ID = ""
   CLIENT_ID = ""
   CLIENT_SECRET = ""
   ```
   **OR** load them directly from `config.json`.
3. Run the notebook to:
   - Authenticate using **Microsoft 365 Graph API**.
   - Fetch the **number of users** in the tenant.
   - Generate a **pie chart** showing user statistics.

---

## Notes
- The **PowerShell script** ensures credentials are not duplicated.
- **Ensure admin consent** is granted for API permissions before running the Python script.
- The **Jupyter Notebook** assumes at least 1 user is present in the tenant.

For troubleshooting, refer to:
- **Azure CLI Docs:** [Microsoft Docs](https://learn.microsoft.com/en-us/cli/azure/)
- **Graph API Docs:** [Microsoft Graph API](https://learn.microsoft.com/en-us/graph/api/overview)
                                                                            
 ---                                                                        
                                                                            
 ## Project Structure                                                     
                                                                            
 ```                                                                       
 m365-python/                                                             
                                                                        
 ├── graph_api_example.ipynb     # Jupyter Notebook with the Python example   
 ├── setup-appregistration.ps1   # PowerShell script for app registration setup 
 ├── requirements.txt            # List of Python dependencies                
 └── README.md                   # Project documentation                        
 ```                                                                       
