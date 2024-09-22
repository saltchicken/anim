import os
import platform
import subprocess


def run_script():
    # Get the directory of the current script
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Define the script paths relative to the current script's directory
    windows_script = os.path.join(script_dir, "scripts/script.bat")
    linux_script = os.path.join(script_dir, "scripts/remove_video_background.sh")

    # Check the current OS
    current_os = platform.system()

    try:
        if current_os == "Windows":
            # Run the .bat file on Windows
            print(f"Detected Windows. Running the .bat file: {windows_script}")
            subprocess.run([windows_script], shell=True)
        elif current_os == "Linux":
            # Run the .sh file on Linux
            print(f"Detected Linux. Running the .sh file: {linux_script}")
            subprocess.run(["bash", linux_script], check=True)
        else:
            print(f"Unsupported OS: {current_os}")
    except Exception as e:
        print(f"Error occurred while running the script: {e}")


if __name__ == "__main__":
    run_script()
