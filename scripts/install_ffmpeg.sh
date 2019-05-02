#!/bin/bash

wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz -O /root/ffmpeg.tar.xz
mkdir -p /opt/tools/ffmpeg
cd /opt/tools/ffmpeg
tar xf /root/ffmpeg.tar.xz
mv ffmpeg-*-static/ffmpeg .
rm -rf ffmpeg-*-static
rm -rf /root/ffmpeg.tar.xz


