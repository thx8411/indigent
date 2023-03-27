#!/usr/bin/python

#
# work in progress
#

import os
import psutil
from bottle import route, run, template, static_file

# CSS route
@route('/css/<filename>')
def get_css(filename):
    return static_file(filename, root='./css')

# favicon
@route('/favicon.ico')
def get_favicon():
    return static_file('favicon.ico', root='./')

# status
@route('/status')
def status():
    used_cpu=psutil.cpu_percent(interval=1);
    used_ram=psutil.virtual_memory().percent;
    used_disk=psutil.disk_usage('/').percent;
    # check for indiserver process
    indi_proc="No"
    for p in psutil.process_iter(['name']):
        if p.info['name'] == "indiserver":
            indi_proc="Yes"
    return template('status.tpl', cpu=used_cpu, ram=used_ram, disk=used_disk, indi=indi_proc);

# stop
@route('/stop')
def stop():
    os.system('init 0')
    return

# restart
@route('/restart')
def restart():
    os.system('init 6')
    return

# update
@route('/update')
# TODO
def stop():
    return

# reset
@route('/reset')
# TODO
def restart():
    return


# root route
@route('/')
def root():
    # get wifi capabilities
    with os.popen('iwlist wlan0 freq') as stream:
        str=stream.read()

    wifi_channels=str.splitlines()

    wifi_status=wifi_channels[0].find('channels')
    wifi_channels.pop(0)

    return template('root.tpl', wifi_status=wifi_status, wifi_channels=wifi_channels)

run(host='0.0.0.0', port=8080, debug=True, reload=True)

