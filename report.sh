#!/bin/bash

# 1. Check the OS version with linux distro
echo "=== Operating System ==="
if [ -f /etc/os-release ]; then
    cat /etc/os-release
else
    uname -a
fi
echo

# to check  System uptime
echo "=== System Uptime ==="
uptime
echo

# 2. Get the last reboot time
echo "=== Last Reboot ==="
who -b
echo

# 3. Check available CPU cores
echo "=== CPU Cores ==="
lscpu | grep "CPU(s)"
echo

# 4. to check free memory
echo "=== Free Memory ==="
free -h
echo

# 5. Storage status (Disk Usage)
echo "=== Storage Status ==="
df -h
echo

# 6. Check the last installed patches (rpm-based and deb-based)
echo "=== Last Installed Patches ==="
if command -v rpm &>/dev/null; then
    # For RPM-based systems (CentOS, RHEL, Fedora)
    rpm -qa --last | head -10
elif command -v dpkg &>/dev/null; then
    # For DEB-based systems (Ubuntu, Debian)
    dpkg-query -l | grep '^ii' | tail -n 10
else
    echo "Package manager not supported for this distribution."
fi
echo

# 7. check HDD (Disk devices)
echo "=== HDD Information ==="
lsblk
echo

# 8. Check open portson system
echo "=== Open Ports ==="
if command -v netstat &>/dev/null; then
    netstat -plunt
elif command -v ss &>/dev/null; then
    ss -plunt
else
    echo "Neither netstat nor ss command found. Unable to check open ports."
fi
echo

# 9. Check kernel version
echo "=== Kernel Version ==="
uname -r
echo

# 10. Check the list of available kernels (rpm-based and deb-based)
echo "=== Available Kernels ==="
if command -v yum &>/dev/null; then
    # For RPM-based systems (CentOS, RHEL 7)
    yum list available kernel
elif command -v dnf &>/dev/null; then
    # For RPM-based systems (CentOS 8, RHEL 8, Fedora)
    dnf list available kernel
elif command -v apt &>/dev/null; then
    # For DEB-based systems (Ubuntu, Debian)
    apt-cache search linux-image
else
    echo "Package manager not supported for this distribution."
fi
echo

echo "Monthly report completed"

