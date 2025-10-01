# Project: Automated New Hire Onboarding Provisioner

**Author:** Seth Yang
**Contact:** sethyang7531@gmail.com
**LinkedIn:** https://www.linkedin.com/in/seth-yang-a1b8941b8/

---

### **Summary**

As an IT Support Specialist, I was on the front lines of our new hire onboarding process. I saw firsthand how manual, repetitive tasks were creating a significant bottleneck that delayed getting our new team members ready for day one. This project is the solution I designed and proposed to fix that. It's a PowerShell script that automates the entire IT checklist creation process, ensuring a consistent, error-free, and dramatically faster onboarding experience.

---

### **From the Front Lines: Identifying the Bottleneck**

In my role as an IT Support Specialist I, I was directly responsible for setting up new hire equipment. I noticed a pattern: our team was constantly in a reactive state. The process started when HR would drop a PDF form into a shared drive, and it would often sit there until a technician had a free moment to even look at it.

From my perspective, this created a few key problems:

*   **Lost Time:** There was a significant lag between HR completing their task and IT beginning ours. This "dead time" was a pure inefficiency that directly delayed a new hire's start.
*   **The Risk of Manual Entry:** I would have to manually transcribe details from the HR form to create our own IT checklist. It was tedious work, and with a high volume of new hires, it was easy to make a small mistake—like missing a specific software license or grabbing the wrong type of monitor adapter.
*   **An Inconsistent Experience:** Every technician had their own slightly different mental checklist. This meant one new hire might have a perfect first day, while another would have to submit a follow-up ticket for a missing piece of equipment. It wasn't a reliable system.

I knew this wasn't just an IT issue; it was impacting the entire company's first impression on our new talent.

---

### **Taking Initiative: Proposing the Solution**

I believe that identifying a problem is only half the job. Even though my role was focused on support tickets, I felt a responsibility to help improve our processes.

I mapped out a solution: a script that could watch the HR folder and automatically generate a standardized IT checklist the moment a new form arrived. I put together a brief proposal outlining the problem, my proposed automated workflow, and the expected benefits—less manual work for our team and a better experience for new hires.

I presented this idea to my IT Director. The concept was well-received, and it was green-lit as an official initiative. We held a couple of follow-up meetings where I walked the team through my plan, gathered their feedback, and refined the checklist requirements to ensure it met everyone's needs. This wasn't just a personal project; it became a collaborative effort to innovate our department's workflow.

---

### **The Build Process: How I Brought It to Life**

With the team's buy-in, I got to work building the solution. My development process was straightforward and methodical:

1.  **Defining the Core Needs:** I started by solidifying the exact requirements we'd discussed—the standard hardware list, essential software, and access permissions that every new hire needed.

2.  **Choosing the Right Tool:** I decided to use PowerShell because it's native to our Windows environment and is the perfect tool for system administration and automation. It's powerful, reliable, and something the rest of the team could easily understand and maintain.

3.  **Developing the Script:** I designed the script to be simple but effective. It continuously monitors the designated HR folder. When it detects a new PDF, it prompts the technician for the new hire's essential details. I used a clean, multi-line "here-string" in the code to serve as a master template, making it incredibly easy to update the checklist in the future.

4.  **Testing and Refining:** I set up a local test environment to simulate the entire workflow, ensuring the script was robust and handled everything as expected before deploying it.

5.  **Documentation for the Team:** The final step was creating this `README` file. My goal was for any technician on my team to be able to understand the "why" behind the project and how to use it without needing me to explain it.

---

### **Key Features & Tangible Benefits**

*   ✅ **Proactive Automation:** The process now begins automatically, eliminating the initial delay.
*   ⚙️ **Guaranteed Consistency:** Every new hire gets the exact same, high-quality setup, every single time.
*   ⏱️ **Efficiency Boost:** Frees up valuable technician time from manual data entry, allowing us to focus on more complex IT challenges.
*   📋 **Built-in Audit Trail:** Creates a clear, dated record of every new hire setup for easy tracking.
*   🚀 **A Better First Day:** New hires can be productive from the moment they walk in, contributing to a positive and professional company culture.

---

### **How to Use**

1.  **Configuration:** Open the `Start-Onboarding.ps1` script and modify the `$HRFormsPath` and `$ITChecklistsPath` variables to match your organization's shared drive locations.
2.  **Execution:** Run the script from a PowerShell console on a machine with access to the specified network shares.
3.  **Monitoring:** The script will run in the background, checking for new files every 60 seconds.
4.  **Provisioning:** When a new "Hire Checklist" PDF is added by HR, the script will trigger, prompt for the new hire's details, and instantly generate the IT checklist in the output folder.
