from multiprocessing import Pool
import sys
import os
import re

def do_command(command):
    os.system(command)

def go():
    ffmpeg_bin = os.path.join(".", "ffmpeg", "ffmpeg", "bin", "ffmpeg.exe")
    from_dir = "vids_todo"
    dst_dir = "result"

    list_commands = []

    for i in os.listdir(from_dir):
        full_path = os.path.join(from_dir, i)
        new_name = re.sub(r'[^\x00-\x7f]',r'', i)
        full_dst = os.path.join(dst_dir, new_name)
        ext = full_dst.split(".")[-1]
        full_dst = full_dst.replace(ext, "mp3")
        cmd = "{} -i \"{}\" -b:a 320K -vn \"{}\"".format(ffmpeg_bin, full_path, full_dst)
        #print cmd
        list_commands.append(cmd)

    threadPool = Pool(4)
    threadPool.map(do_command, list_commands)
    threadPool.close()
    threadPool.join()

if __name__ == '__main__':
    go()