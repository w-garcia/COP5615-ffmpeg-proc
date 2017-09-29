# FFMPEG_PROC

This project acts as a daemon-style folder watcher for converting any (LEGALLY OBTAINED) videos to .mp3 format. The program is extension agnostic and takes arguments of the form:

```
./ffmpeg_proc <input_dir> <output_dir>
```

The program will keep track of the files in the input_dir, and save these files as .mp3 to the output_dir. This means files can be dragged and dropped into the input_dir and the program will automatically perform conversion. 

## Dependencies:

ffmpeg must be installed either system-wide or downloaded to the directory where the program is run from. For system wide, simply do:

```
sudo apt-get install ffmpeg
```

Alternatively, your distribution of Linux may already have it installed. 

## Installation:


```
mix escript.build
./ffmpeg_proc <input_dir> <output_dir>
```

To run on the sample video provided, simply do:

```
./ffmpeg_proc videos/ out/
```

Where out/ can be replaced by a directory of your choice.


## Royalty Free Video Attribution

This project comes with one youtube video as a sample in the videos directory.

Original sample video: https://www.youtube.com/watch?v=ZVrOUnWVZ6s

