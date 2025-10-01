# Project: Automated New Hire Onboarding Provisioner

**Author:** Seth Yang
**Contact:** sethyang7531@gmail.com
**LinkedIn:** [Your LinkedIn Profile URL Here]

---

### **Summary**

The `New-Hire_Onboarding_Provisioner` is a PowerShell script designed to automate and standardize the IT equipment and access provisioning process for new employees. This project was born from identifying a critical bottleneck in the manual onboarding workflow. By automating the creation of a standardized checklist the moment HR submits their request, this tool eliminates administrative delays, prevents human error, and ensures a consistent and positive day-one experience for every new hire.

---

### **The Business Problem: Identifying the Onboarding Bottleneck**

In my role supporting IT operations, I observed a recurring bottleneck in our new hire onboarding process. The workflow was entirely manual and reactive, which created several distinct "pain points":

1.  **The Manual Handoff:** Our process began when HR manually uploaded a PDF checklist to a shared drive. Our IT team then had to remember to constantly check that folder. If a technician was busy with another critical issue, the form could sit there for hours, delaying the entire process before it even started.

2.  **Repetitive, Error-Prone Work:** Once an IT technician saw the form, they would have to manually create a *new* checklist, transcribing details from the HR document. This introduced a high risk of human error—forgetting a specific piece of hardware, misspelling a name, or missing a special software request from a supervisor.

3.  **Inconsistent Setups:** Different technicians had slightly different ways of setting up their checklists. This led to inconsistencies where one new hire might get a docking station and another might not, simply because it was missed on a manually created list. This resulted in follow-up tickets and a frustrating first-day experience for the new employee.

I realized that the core problem wasn't the people, but the process. I hypothesized that if I could automate the creation of a standardized, IT-ready checklist, we could **eliminate the delay, remove the risk of human error, and guarantee a consistent, positive day-one experience** for every new employee.

---

### **The Solution: A Proactive, Automated Workflow**

To solve this, I developed a lightweight, automated provisioning tool using PowerShell. I followed a clear, step-by-step process to ensure the solution was robust and professional:

**Step 1: Discovery and Requirements Gathering**
*   First, I defined the exact requirements. I confirmed the standard list of hardware (laptop, monitors, etc.), the necessary account and license types, and access control requirements (like building badges).
*   I established that the trigger for the entire workflow would be the appearance of a new PDF file in a specific network share.

**Step 2: Designing the Automated Workflow**
*   I mapped out the logic before writing any code:
    *   **Monitor:** The script needed to watch a specific "HR Drop" folder.
    *   **Trigger:** Upon detecting a new PDF, the script would activate.
    *   **Input:** It would then prompt the IT technician to enter the new hire's details. This was a deliberate design choice for simplicity and reliability.
    *   **Process:** Using a built-in template, the script would dynamically generate a new checklist.
    *   **Output:** The final checklist would be saved as a clean Markdown file in a separate "IT Checklists" folder, named with the employee's name and the date for easy auditing.

**Step 3: Script Development in PowerShell**
*   I chose PowerShell as it is the industry standard for Windows system administration and automation.
*   I used a `while` loop for continuous monitoring and a `here-string` (`@"..."@`) to create a clean, multi-line template for the checklist.
*   I included comments and clear variable names to ensure the script was maintainable and easy for other team members to understand.

**Step 4: Testing and Refinement**
*   I created a local test environment with mock "HR" and "IT" folders to test the script thoroughly.
*   I checked for edge cases, such as handling names with special characters and ensuring the script could create the directories if they didn't already exist.

**Step 5: Documentation and Deployment**
*   The final step was creating this comprehensive `README.md` file. This documentation explains the problem the script solves, its benefits, and provides clear instructions on how to use it, turning a simple script into a complete, reusable solution.

---

### **Key Features & Benefits**

*   ✅ **100% Automation:** Eliminates the need for manual checklist creation and monitoring.
*   ⚙️ **Standardization:** Ensures every new hire receives a consistent and complete equipment package.
*   ⏱️ **Increased Efficiency:** Drastically reduces the administrative time spent by IT technicians on repetitive tasks.
*   📋 **Audit Trail:** Automatically creates a dated record of every onboarding checklist for compliance and tracking.
*   🚀 **Improved Employee Experience:** New hires get the tools they need faster, leading to a smoother and more positive start.

---

### **How to Use**

1.  **Configuration:** Open the `Start-Onboarding.ps1` script and modify the `$HRFormsPath` and `$ITChecklistsPath` variables to match your organization's shared drive locations.
2.  **Execution:** Run the script from a PowerShell console on a machine with access to the specified network shares.
3.  **Monitoring:** The script will run in the background, checking for new files every 60 seconds.
4.  **Provisioning:** When a new "Hire Checklist" PDF is added by HR, the script will trigger, prompt for the new hire's details, and instantly generate the IT checklist in the output folder.
