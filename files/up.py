#!/usr/bin/env python

lines = open("/var/www/sr/_gen/ffmpeg.txt","r")
outputfile = open("/etc/supervisord.d/streams.ini", "w")

rootpath = "/mnt/streams"
ffmpeg = "/opt/tools/ffmpeg/ffmpeg"

tpl = """[program:{{name}}]
command=/bin/bash -c "mkdir -p {{rootpath}}/{{name}}; cd {{rootpath}}/{{name}}; {{ffmpeg}} -xerror -nostats -nostdin -i "{{ip}}" -codec copy -map 0:0 -map 0:1 -map_metadata 0  {{snum}} -hls_flags delete_segments -hls_time 5 -segment_list_size 3 -hls_segment_filename file%%07d.ts stream.m3u8"
autostart = true
startsec = 1
user = root
redirect_stderr = true
stdout_logfile_maxbytes = 40MB
stdoiut_logfile_backups = 20
stdout_logfile = /var/log/supervisor/ch-{{name}}.log
autorestart=true
startretries=5000000000
stopasgroup=true
killasgroup=true
stdout_events_enabled=true
stderr_events_enabled=true

"""
output = ""
for line in lines:
	parts = line.strip().split(" ")
	output += tpl.replace("{{ffmpeg}}", ffmpeg).replace('{{rootpath}}',rootpath).replace('{{name}}', parts[0]).replace("{{ip}}", parts[1]).replace("{{snum}}","")
outputfile.write(output)
