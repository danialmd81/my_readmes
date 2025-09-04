# openSUSE Post Installation Setup

This project provides a shell script (`main.sh`) that automates the installation and configuration of various software and tools on an openSUSE system. The script simplifies the setup process by executing a series of commands to update the system, install essential applications, and configure development environments.

## Getting Started

To use the `main.sh` script, follow these steps:

1. **Clone the Repository**:
   Clone this repository to your local machine using the following command:

   ```
   git clone <repository-url>
   ```

2. **Navigate to the Directory**:
   Change to the project directory:

   ```
   cd openSUSE-post-installation
   ```

3. **Make the Script Executable**:
   Before running the script, ensure it is executable:

   ```
   chmod +x main.sh
   ```

4. **Run the Script**:
   Execute the script with root privileges to start the installation process:

   ```
   sudo ./main.sh
   ```

## Included Software and Configurations

The `main.sh` script installs and configures the following software:

- System updates and upgrades
- Essential applications (e.g., text editors, development tools)
- Git configuration for version control
- Development environments for various programming languages

## Notes

- Ensure you have a stable internet connection during the installation process.
- Review the script for any specific configurations or software that may need to be adjusted based on your requirements.

## License
