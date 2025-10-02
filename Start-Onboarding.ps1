<#
.SYNOPSIS
    Automates the creation of a standardized IT onboarding checklist for new hires.
.DESCRIPTION
    This script monitors a specified folder for new hire forms. When a new PDF is
    detected, it prompts the IT technician for the new hire's details, and then
    automatically generates a professional, auditable checklist in Markdown format.
.AUTHOR
    Seth Yang
#>

# --- CONFIGURATION ---
# These are the names of the folders the script will use. They will be created
# in the same directory where this script is saved.
$HRFormsFolder = "_HR_Requests"
$ITChecklistsFolder = "_IT_Checklists"
# --- END CONFIGURATION ---


# --- INITIALIZATION ---
# Use $PSScriptRoot to make sure the script can find its files
# no matter where you run it from. This is a key best practice for portability.
$scriptRoot = $PSScriptRoot
$watchPath = Join-Path $scriptRoot $HRFormsFolder
$outputPath = Join-Path $scriptRoot $ITChecklistsFolder

# Clear the screen for a clean start
Clear-Host

# Create the necessary folders if they don't already exist.
if (-not (Test-Path $watchPath)) { New-Item -ItemType Directory -Path $watchPath | Out-Null }
if (-not (Test-Path $outputPath)) { New-Item -ItemType Directory -Path $outputPath | Out-Null }


# --- Display a welcome message ---
Write-Host "-------------------------------------" -ForegroundColor Cyan
Write-Host "    IT ONBOARDING AUTOMATOR ACTIVE   "
Write-Host "-------------------------------------" -ForegroundColor Cyan
Write-Host "Monitoring for new HR forms in: `"$HRFormsFolder`""
Write-Host "Generated checklists will be saved in: `"$ITChecklistsFolder`""
Write-Host "Press CTRL+C to stop the script."
Write-Host ""


# --- CORE LOGIC ---
# Using a HashSet is an efficient way to keep track of files we've already processed.
$processedFiles = New-Object System.Collections.Generic.HashSet[string]

# The main loop that watches for files.
while ($true) {
    # Get a list of any PDF files in our watch folder.
    $files = Get-ChildItem -Path $watchPath -Filter "*.pdf"

    foreach ($file in $files) {
        # Only process files we haven't seen before.
        if (-not $processedFiles.Contains($file.FullName)) {

            Write-Host "[$(Get-Date -Format 'T')] New HR form detected: $($file.Name)" -ForegroundColor Yellow
            $processedFiles.Add($file.FullName) | Out-Null

            # --- GATHER NEW HIRE INFORMATION ---
            # Prompt the technician for the necessary details.
            $hireName = Read-Host "-> Please enter the new hire's full name"
            $hireDepartment = Read-Host "-> Please enter their department (e.g., Sales, Engineering)"
            $supervisorRequests = Read-Host "-> Enter any specific items requested by their supervisor (or leave blank)"

            # Sanitize the name for use in a filename.
            $fileNameSafeName = $hireName -replace '[^a-zA-Z0-9]', '_'
            $dateStamp = Get-Date -Format "yyyy-MM-dd"
            $outputFileName = "$($fileNameSafeName)_Onboarding_Checklist_$($dateStamp).md"
            $outputFilePath = Join-Path $outputPath $outputFileName

            # --- CHECKLIST TEMPLATE ---
            # This 'here-string' contains the full Markdown template for the checklist.
            # It's easy to read and update right here in the script.
            $checklistContent = @"
# IT Onboarding Checklist: $hireName

- **Date Generated:** $dateStamp
- **Department:** $hireDepartment
- **Assigned IT Tech:** _________________________

---

### 1. Hardware Provisioning

- [ ] **Laptop:** (Asset Tag: ____________________)
- [ ] **Charger:**
- [ ] **Docking Station:**
- [ ] **Monitor(s) (x2):** (Serials: ____________________)
- [ ] **Mouse & Keyboard:**
- [ ] **Headset:**

---

### 2. Account & License Provisioning

- [ ] **Active Directory Account Created:** (Username: ____________________)
- [ ] **Microsoft 365 License Assigned:** (Type: ____________________)
- [ ] **Email Mailbox Created:**
- [ ] **Departmental Security Groups Assigned:**
- [ ] **Application Licenses (Specify):**

---

### 3. Access Control

- [ ] **Building Access Badge Requested/Activated:** (Badge #: ____________________)
- [ ] **Server/Folder Permissions Assigned (as required):**

---

### 4. Supervisor's Special Requests

- **Requests:** $($supervisorRequests -ifempty "None")

---

### **Final Verification and Sign-Off**

*This section is to be completed by both the IT Technician and the New Hire upon hand-off of the equipment.*

#### **IT Technician Verification**
*I confirm that all checked items listed above have been provisioned, installed, and tested to be in working order.*

- **Printed Name:** _________________________
- **Signature:** _________________________
- **Date Completed:** _________________________

---

#### **New Hire Acknowledgment**
*I acknowledge that I have received all the equipment and access listed above. I have performed a basic login test and verified that the hardware is in good working condition.*

- **Printed Name:** $hireName
- **Signature:** _________________________
- **Date Received:** _________________________
"@

            # --- WRITE THE CHECKLIST FILE ---
            try {
                Set-Content -Path $outputFilePath -Value $checklistContent
                Write-Host "SUCCESS: Successfully generated checklist: $outputFileName" -ForegroundColor Green
                Write-Host ""
            }
            catch {
                Write-Host "ERROR: Could not write to file at $outputFilePath. Check permissions." -ForegroundColor Red
            }
        }
    }
    # Wait for 10 seconds before checking the folder again.
    Start-Sleep -Seconds 10
}
