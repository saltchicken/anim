import os
import platform
import subprocess
import argparse


def run_script():
    parser = argparse.ArgumentParser(description="Anim Main")
    parser.add_argument("input_file", help="Path to the input file")
    args = parser.parse_args()

    input_file = args.input_file
    windows_script = os.path.join("scripts", "windows_remove_video_background.bat")
    linux_script = os.path.join("scripts/remove_video_background.sh")

    # Check the current OS
    current_os = platform.system()

    try:
        if current_os == "Windows":
            # Run the .bat file on Windows
            print(f"Detected Windows. Running the .bat file: {windows_script}")
            subprocess.run([windows_script, input_file], shell=True)
        elif current_os == "Linux":
            # Run the .sh file on Linux
            print(f"Detected Linux. Running the .sh file: {linux_script}")
            subprocess.run(["bash", linux_script, input_file], check=True)
        else:
            print(f"Unsupported OS: {current_os}")
    except Exception as e:
        print(f"Error occurred while running the script: {e}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Anim Main")
    parser.add_argument("input_file", help="Path to the input file")
    args = parser.parse_args()

    # run_script(args)
