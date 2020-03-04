#!/usr/bin/env python

lines = open("/var/www/sr/_gen/ffmpeg.txt","r")
outputfile = open("/etc/supervisord.d/proxies.ini", "w")

tpl = """[program:proxy-{{name}}]
command=/opt/tools/hls-proxy_linux_amd64 --url "{{ip}} --name "{{name}}" --frontend http://127.0.0.1:8085
autostart = true
startsec = 1
user = root
redirect_stderr = true
stdout_logfile_maxbytes = 40MB
stdoiut_logfile_backups = 20
stdout_logfile = /var/log/supervisor/ch-proxy-{{name}}.log
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
	output += tpl.replace('{{name}}', parts[0]).replace("{{ip}}", parts[1].replace("%","%%")).replace("{{snum}}","")
outputfile.write(output)
