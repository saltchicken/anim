from setuptools import setup, find_packages

setup(
    name="anim",
    version="0.1",
    packages=find_packages(),
    include_package_data=True,
    data_files=[("scripts", ["scripts/remove_video_background.sh"])],
    entry_points={
        "console_scripts": [
            "anim=anim_main.main:run_script",
        ],
    },
    install_requires=[
        # List any dependencies here, e.g., 'requests',
    ],
)
