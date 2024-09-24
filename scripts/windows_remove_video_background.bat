@echo off
set INPUT_VIDEO=%1
set OUTPUT_FOLDER=processed_%INPUT_VIDEO%
set INPUT_VIDEO_NO_EXTENSION=%~n1
set OUTPUT_FILE=%INPUT_VIDEO_NO_EXTENSION%_anim.mkv

mkdir frames
ffmpeg -i %INPUT_VIDEO% -r 15 -q:v 2 frames/frame_%%04d.png
rembg p frames %OUTPUT_FOLDER%
ffmpeg -framerate 15 -i "%OUTPUT_FOLDER%\frame_%%04d.png" -c:v ffv1 -pix_fmt yuva420p -f matroska %OUTPUT_FILE%

rmdir /S /Q frames
rmdir /S /Q %OUTPUT_FOLDER%

