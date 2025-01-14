WSL-Docker Port Forwarding Manager CLI
===============================================

This PowerShell script is a simple CLI tool designed to manage port forwarding rules on a Windows machine. It allows users to list, add, and remove port forwarding rules for connections between a Windows host and WSL (Windows Subsystem for Linux).

Features
--------

1.  **List Existing Rules**: Display currently active port forwarding rules.
2.  **Add New Rule**: Add a new port forwarding rule between a Windows IP/port and a WSL IP/port.
3.  **Remove Rule**: Remove a port forwarding rule by specifying the Windows IP and port.

Requirements
------------

-   PowerShell (Windows or PowerShell 7+ recommended).
-   Administrator privileges (required for managing port forwarding rules).

Usage
-----

### 1\. **Listing Existing Port Forwarding Rules**

To list the current port forwarding rules:

-   Select option **1** from the menu.
-   This will run `netsh interface portproxy show all` to display the active rules.

### 2\. **Adding a New Port Forwarding Rule**

To add a new port forwarding rule:

-   Select option **2** from the menu.
-   Enter the following details when prompted:
    -   **Windows Host IP**: The IP address of the Windows machine (e.g., `192.168.1.100`).
    -   **Windows Host Port**: The port on the Windows machine you wish to forward (e.g., `8080`).
    -   **WSL IP**: The IP address of your WSL instance (e.g., `172.18.8.1`).
    -   **WSL Port**: The port on your WSL instance to forward to (e.g., `80`).
-   The script will then add the rule using the `netsh` command.

### 3\. **Removing a Port Forwarding Rule**

To remove a port forwarding rule:

-   Select option **3** from the menu.
-   Enter the **Windows Host IP** and **Windows Host Port** associated with the rule you wish to remove.
-   The script will delete the rule using the `netsh` command.

### 4\. **Exiting the Script**

To exit the script:

-   Simply press **Ctrl + C** at any time or select option **4** to exit (if added).

Example Workflow
----------------

```
Port Forwarding Manager CLI
1. List Existing Rules
2. Add New Rule
3. Remove Rule

Enter your choice (1-3) or Ctrl + C to exit: 1

Listing existing port forwarding rules...
Protocol  LocalAddress          LocalPort  ForeignAddress       ForeignPort
--------  --------------------  ---------  --------------------  ----------
TCP       192.168.1.100        8080       172.18.8.1           80
TCP       192.168.1.100        443        172.18.8.1           443
```

* * * * *

Installation and Setup
----------------------

### 1\. **Download Script**

You can either download or copy the contents of the script into a `.ps1` file (e.g., `PortForwardingManager.ps1`) manually.

Or you can use `git clone https://github.com/FluffyClaws/win-docker-port-forwarding`

### 2\. **Run Script with Administrator Privileges**

The script needs to be run with administrator privileges to manage port forwarding rules. To run the script:

-   Open **PowerShell** as an administrator.

-   Navigate to the folder where the script is saved.

-   Run the script using the following command:

    powershell

    Copy code

    `.\PortForwardingManager.ps1`

Alternatively, you can configure your script to be launched with administrator rights by creating a shortcut or using a command line (see the instructions in previous responses for running with admin privileges).

Error Handling
--------------

-   If you attempt to add or remove a rule with missing or incorrect information (e.g., IP address or port), the script will prompt you to enter all required fields.
-   The script will notify you if a rule is successfully added or removed.

* * * * *

Troubleshooting
---------------

-   If the script doesn't run, ensure you are running it as an administrator.
-   If port forwarding is not working as expected, check that the WSL instance is correctly configured and accessible on the specified IP.
