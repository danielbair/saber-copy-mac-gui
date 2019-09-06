#!/bin/bash

diskutil info -all 2>/dev/null | grep Point -B 9 | grep 'Node\|Point'

for dir in {028..031}; do for file in `ls -1v 0$dir/001`; do ffmpeg -i 0$dir/001/$file -y -vn -ac 2 -codec:a libmp3lame -ab 64k -ar 22050 -joint_stereo 1 /tmp/tmp.mp3; mv -v /tmp/tmp.mp3 0$dir/001/$file; done; done

IFS=$'\n'; for dir in /Volumes/SGAW\ KAREN*; do echo $dir/001/ >> /tmp/SGAW_KAREN_Drives.txt; done
sudo rm -rfv /Volumes/SGAW\ KAREN*/001/030\ -\ Sermons/; IFS=$'\n'; cat /tmp/SGAW_KAREN_Drives.txt | parallel --will-cite -j 5 rsync -amz --stats --safe-links --ignore-existing --delete "/Volumes/Seagate\ Backup\ Plus\ Drive/SGAW\ KAREN\ -\ MegaVoice\ Envoy\ 2S/001/" "{}"
IFS=$'\n'; for dir in /Volumes/SGAW\ KAREN*; do diskutil eject $dir; done

