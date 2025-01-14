# Function to list existing port forwarding rules
function List-PortForwarding {
    Write-Host "Listing existing port forwarding rules..."
    $rules = netsh interface portproxy show all
    Write-Output $rules
}

# Function to add port forwarding rule
function Add-PortForwarding {
    param (
        [string]$WindowsHostIP,
        [int]$WindowsHostPort,
        [string]$WSLIP,
        [int]$WSLPort
    )
    Write-Host "Adding port forwarding rule..."
    Start-Process "netsh" -ArgumentList "interface portproxy add v4tov4 listenaddress=$WindowsHostIP listenport=$WindowsHostPort connectaddress=$WSLIP connectport=$WSLPort" -Wait -NoNewWindow
    Write-Host "Port forwarding rule added successfully!"
}

# Function to remove port forwarding rule
function Remove-PortForwarding {
    param (
        [string]$WindowsHostIP,
        [int]$WindowsHostPort
    )
    Write-Host "Removing port forwarding rule..."
    Start-Process "netsh" -ArgumentList "interface portproxy delete v4tov4 listenaddress=$WindowsHostIP listenport=$WindowsHostPort" -Wait -NoNewWindow
    Write-Host "Port forwarding rule removed successfully!"
}

# Display menu and process user input
function Show-Menu {
    Write-Host "Port Forwarding Manager CLI"
    Write-Host "1. List Existing Rules"
    Write-Host "2. Add New Rule"
    Write-Host "3. Remove Rule"
    Write-Host ""
    $choice = Read-Host "Enter your choice (1-3) or Ctrl + C to exit"
    return $choice
}

# Main CLI loop
while ($true) {
    $choice = Show-Menu
    switch ($choice) {
        "1" {
            # List existing rules
            $rules = List-PortForwarding
            Write-Host "`nExisting Port Forwarding Rules:"
            Write-Output $rules
        }
        "2" {
            # Add new rule
            $WindowsHostIP = Read-Host "Enter Windows Host IP"
            $WindowsHostPort = Read-Host "Enter Windows Host Port"
            $WSLIP = Read-Host "Enter WSL IP"
            $WSLPort = Read-Host "Enter WSL Port"
            if ($WindowsHostIP -and $WindowsHostPort -and $WSLIP -and $WSLPort) {
                Add-PortForwarding -WindowsHostIP $WindowsHostIP -WindowsHostPort $WindowsHostPort -WSLIP $WSLIP -WSLPort $WSLPort
            } else {
                Write-Host "All fields are required to add a port forwarding rule!"
            }
        }
        "3" {
            # Remove existing rule
            $WindowsHostIP = Read-Host "Enter Windows Host IP to remove"
            $WindowsHostPort = Read-Host "Enter Windows Host Port to remove"
            if ($WindowsHostIP -and $WindowsHostPort) {
                Remove-PortForwarding -WindowsHostIP $WindowsHostIP -WindowsHostPort $WindowsHostPort
            } else {
                Write-Host "Both Windows Host IP and Port are required to remove a rule!"
            }
        }

        default {
            Write-Host "Invalid choice. Please enter a number between 1 and 4."
        }
    }
}
