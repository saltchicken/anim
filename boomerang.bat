@echo off
set INPUT_FILE=%1
set INPUT_FILE_NO_EXTENSION=%~n1

ffmpeg -i "%INPUT_FILE%" -vf reverse -af areverse -y reversed.mp4

(echo file %INPUT_FILE% & echo file reversed.mp4) >> concat.txt
ffmpeg -f concat -i concat.txt -safe 0 -c copy "%INPUT_FILE_NO_EXTENSION%_boomerang.mp4"
del concat.txt
del reversed.mp4

