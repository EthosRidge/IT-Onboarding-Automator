<#
.SYNOPSIS
    Automates the creation of an IT onboarding checklist for new hires.
.DESCRIPTION
    This script monitors a specified network folder for new hire forms submitted by HR.
    When a new form (PDF) is detected, it prompts the IT technician for the new hire's
    details, and then automatically generates a standardized markdown checklist for the IT department.
.AUTHOR
    Seth Yang
.VERSION
    1.1 - Added employee signature line for accountability.
#>

# --- CONFIGURATION ---
# Set the path to the folder where HR drops new hire checklist forms.
$HRFormsPath = "C:\Temp\HR_Requests"
# Set the path where the generated IT checklists will be saved.
$ITChecklistsPath = "C:\Temp\IT_Checklists"
# --- END CONFIGURATION ---

# --- SCRIPT BODY ---

# Check if the source and destination directories exist. If not, create them.
if (-not (Test-Path $HRFormsPath)) {
    Write-Host "HR requests folder not found. Creating it at: $HRFormsPath"
    New-Item -Path $HRFormsPath -ItemType Directory | Out-Null
}
if (-not (Test-Path $ITChecklistsPath)) {
    Write-Host "IT checklists folder not found. Creating it at: $ITChecklistsPath"
    New-Item -Path $ITChecklistsPath -ItemType Directory | Out-Null
}

Write-Host "Monitoring folder for new hire forms: $HRFormsPath" -ForegroundColor Green
Write-Host "Press CTRL+C to stop the script."

# A simple set to keep track of files that have already been processed.
$processedFiles = New-Object System.Collections.Generic.HashSet[string]

# Begin an infinite loop to monitor the directory.
while ($true) {
    # Get all PDF files in the HR forms directory.
    $files = Get-ChildItem -Path $HRFormsPath -Filter "*.pdf"

    foreach ($file in $files) {
        # Check if the file has already been processed in this session.
        if (-not $processedFiles.Contains($file.FullName)) {

            Write-Host "`nNew HR form detected: $($file.Name)" -ForegroundColor Yellow

            # --- GATHER NEW HIRE INFORMATION ---
            $hireName = Read-Host "Please enter the new hire's full name"
            $hireDepartment = Read-Host "Please enter the new hire's department (e.g., Sales, Engineering)"
            $supervisorRequests = Read-Host "Enter any specific items requested by the supervisor (or leave blank)"

            # Sanitize the name for use in a filename.
            $fileNameSafeName = $hireName -replace '[^a-zA-Z0-9]', '_'
            $dateStamp = Get-Date -Format "yyyy-MM-dd"
            $outputFileName = "$($fileNameSafeName)_Onboarding_Checklist_$($dateStamp).md"
            $outputPath = Join-Path $ITChecklistsPath $outputFileName

            # --- CHECKLIST TEMPLATE (UPDATED) ---
            # Using a 'here-string' for a clean, multi-line template.
            $checklistContent = @"
# IT Onboarding Checklist: $hireName

- **Date Generated:** $dateStamp
- **Department:** $hireDepartment
- **Assigned IT Tech:** _________________________

---

### 1. Hardware Provisioning

- [ ] **Laptop:**
- [ ] **Charger:**
- [ ] **Docking Station:**
- [ ] **Monitor(s) (x2):**
- [ ] **Mouse & Keyboard:**
- [ ] **Headset:**

---

### 2. Account & License Provisioning

- [ ] **Active Directory Account Created:**
- [ ] **Microsoft 356 License Assigned (Specify Type):** __________
- [ ] **Email Mailbox Created:**
- [ ] **Departmental Security Groups Assigned:**
- [ ] **Application Licenses (Specify):** __________

---

### 3. Access Control

- [ ] **Building Access Badge Requested/Activated:**
- [ ] **Server/Folder Permissions Assigned (as required):**

---

### 4. Supervisor's Special Requests

- **Requests:** $($supervisorRequests -ifempty "None")

---

### **Onboarding Completion Sign-Off**

I acknowledge that I have received all the equipment and access listed above.

- **IT Technician Signature:** _________________________
- **Employee Signature:** _________________________
- **Date Completed:** _________________________
"@

            # --- WRITE THE CHECKLIST FILE ---
            try {
                Set-Content -Path $outputPath -Value $checklistContent
                Write-Host "Successfully generated checklist: $outputFileName" -ForegroundColor Green

                # Add the file to the processed list so we don't process it again.
                $processedFiles.Add($file.FullName) | Out-Null
            }
            catch {
                Write-Host "Error: Could not write to file at $outputPath" -ForegroundColor Red
            }
        }
    }
    # Wait for 60 seconds before checking the folder again.
    Start-Sleep -Seconds 60
}