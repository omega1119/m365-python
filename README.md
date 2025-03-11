 # m365-python                                                              
                                                                            
 This project demonstrates how to use the Microsoft Graph API in Python     
 with a parameterized configuration, along with a PowerShell script to set   
 up the necessary Azure App Registration. The example retrieves user data   
 from Microsoft 365, processes statistics (e.g., counts by email domain), and 
 visualizes the data using Matplotlib.                                          
                                                                            
 ---                                                                        
                                                                            
 ## Table of Contents                                                       
                                                                            
 - [Prerequisites](#prerequisites)                                          
 - [Environment Setup](#environment-setup)                                  
 - [App Registration Setup](#app-registration-setup)                        
 - [Python Example](#python-example)                                        
 - [PowerShell Script](#powershell-script)                                 
 - [Project Structure](#project-structure)                                 
 - [Contributing](#contributing)                                           
 - [License](#license)                                                     
                                                                            
 ---                                                                        
                                                                            
 ## Prerequisites                                                          
                                                                            
 - **Azure Subscription / Microsoft 365 Tenant:** Access to an Azure AD      
   tenant is required to register an application.                         
 - **PowerShell:** Version 5.x or later.                                    
 - **Python:** Version 3.7 or later.                                        
 - **Jupyter Notebook:** Recommended for running the Python code.         
 - **Required Python Packages:**                                          
   - `requests`                                                           
   - `matplotlib`                                                         
                                                                            
 ---                                                                        
                                                                            
 ## Environment Setup                                                     
                                                                            
 1. **Clone the Repository:**                                               
                                                                            
    ```bash                                                               
    git clone https://github.com/omega1119/m365-python.git                 
    cd m365-python                                                        
    ```                                                                   
                                                                            
 2. **Create and Activate a Virtual Environment (Optional but Recommended): 
                                                                            
    ```bash                                                               
    python -m venv venv                                                   
    # On Windows:                                                        
    venv\Scripts\activate                                                 
    # On macOS/Linux:                                                     
    source venv/bin/activate                                              
    ```                                                                   
                                                                            
 3. **Install Python Dependencies:**                                      
                                                                            
    ```bash                                                               
    pip install -r requirements.txt                                      
    ```                                                                   
                                                                            
    *Alternatively, install manually:*                                   
                                                                            
    ```bash                                                               
    pip install requests matplotlib                                      
    ```                                                                                                                                     
                                                                            
 ---                                                                        
                                                                            
 ## App Registration Setup                                                
                                                                            
 Follow these steps to register an application in Azure AD for accessing     
 the Microsoft Graph API:                                                   
                                                                            
 1. **Run the PowerShell Script:**                                          
    Use the provided PowerShell script (`setup-appregistration.ps1`) to create 
    an app registration, service principal, and client secret.             
                                                                            
    ```powershell                                                         
    .\setup-appregistration.ps1                                           
    ```                                                                   
                                                                            
 2. **Permissions:**                                                      
    - The script demonstrates how to set up delegated permissions like       
      `User.Read` and `User.Read.All`.                                      
    - After running the script, sign in to the [Azure Portal](https://portal.
      azure.com) to verify the API permissions.                           
    - Grant admin consent for the permissions if required.                
                                                                            
 3. **Update Configuration:**                                             
    Note the **Application (client) ID** and **Client Secret** from the       
    script output and update your Python configuration accordingly in the   
    notebook.                                                             
                                                                            
 ---                                                                        
                                                                            
 ## Python Example                                                        
                                                                            
 The Jupyter Notebook (`graph_api_example.ipynb`) contains a Python example   
 that:                                                                     
                                                                            
 1. Retrieves an access token from Azure AD.                              
 2. Calls the Microsoft Graph API to retrieve user data.                  
 3. Processes and visualizes the user data (e.g., counting users by email    
    domain).                                                              
                                                                            
 ### Running the Notebook                                                  
                                                                            
 - Launch Jupyter Notebook:                                               
                                                                            
    ```bash                                                               
    jupyter notebook                                                     
    ```                                                                   
                                                                            
 - Open `graph_api_example.ipynb` and execute the cells step by step.       
 - Update the configuration section with your `tenant_id`, `client_id`,       
   `client_secret`, `username`, and `password`.                           
                                                                            
 ---                                                                        
                                                                            
 ## PowerShell Script                                                     
                                                                            
 The PowerShell script (`setup-appregistration.ps1`) automates the following   
 tasks:                                                                    
                                                                                                                                        
 2. **Create App Registration:**                                          
    Registers a new application in Azure AD with a specified display name,    
    identifier URI, and reply URL.                                        
 3. **Create Service Principal:**                                         
    Sets up a service principal for the app.                              
 4. **Create Client Secret:**                                             
    Generates a client secret (password credential) for authenticating the    
    app.                                                                  
 5. **Assign API Permissions:**                                           
    Retrieves the Microsoft Graph service principal and outlines how to add   
    delegated permissions (manual steps may be needed).                   
                                                                            
 ---                                                                        
                                                                            
 ## Project Structure                                                     
                                                                            
 ```                                                                       
 m365-python/                                                             
                                                                        
 ├── graph_api_example.ipynb     # Jupyter Notebook with the Python example   
 ├── setup-appregistration.ps1   # PowerShell script for app registration setup 
 ├── requirements.txt            # List of Python dependencies                
 └── README.md                   # Project documentation                        
 ```                                                                       
