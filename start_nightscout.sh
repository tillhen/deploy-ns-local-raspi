#!/bin/sh
cd /home/pi/cgm-remote-monitor

# See https://github.com/nightscout/cgm-remote-monitor#environment for a description of the fields
# Required by Nightscout, please edit
export CUSTOM_TITLE="jamesnightscout"
export API_SECRET=thisiswonderful

# 
# Required by Nightscout
# Used for building links to your sites api, ie pushover callbacks, usually the URL of your Nightscout site 
# TODO: get the FQDN here
BASE_URL="http://`hostname`:1337/"

# Required by Nightscout
# Your mongo uri, for example: mongodb://sally:sallypass@ds099999.mongolab.com:99999/nightscout
# TODO: secure mongo collection with generated username / password
export MONGO_CONNECTION=mongodb://localhost:27017/nightscout

# DISPLAY_UNITS. Choices: mg/dl and mmol. Setting to mmol puts the entire server into mmol mode by default, no further settings needed
#export DISPLAY_UNITS=mmol
export DISPLAY_UNITS=mmol

export ENABLE="delta direction timeago devicestatus ar2 profile careportal boluscalc food rawbg iob cors cob bwp cage sage iage treatmentnotify basal pump openaps bage"
export DISABLE="simplealarms bridge mmconnect loop upbat"

export TIME_FORMAT=24
export NIGHT_MODE=off
export SHOW_RAWBG=always

export THEME=colors

export ALARM_TIMEAGO_WARN=off
export ALARM_TIMEAGO_WARN_MINS=15
export ALARM_TIMEAGO_URGENT=off
export ALARM_TIMEAGO_URGENT_MINS=30

export BG_HIGH=200
export BG_TARGET_TOP=180
export BG_LOW=65
export BG_TARGET_BOTTOM=70

export PROFILE_HISTORY=off
export PROFILE_MULTIPLE=off

export BWP_WARN=0.50
export BWP_URGENT=1.00
export BWP_SNOOZE_MINS=10
export BWP_SNOOZE=0.10

export CAGE_ENABLE_ALERTS=true
export CAGE_INFO=44
export CAGE_WARN=48
export CAGE_URGENT=72
export CAGE_DISPLAY=days

export SAGE_ENABLE_ALERTS=false
export SAGE_INFO=144
export SAGE_WARN=164
export SAGE_URGENT=166

export IAGE_ENABLE_ALERTS=false
export IAGE_INFO=44
export IAGE_WARN=48
export IAGE_URGENT=72

export BAGE_ENABLE_ALERTS=false
export BAGE_INFO=44
export BAGE_WARN=48
export BAGE_URGENT=72
export BAGE_DISPLAY=days

export TREATMENTNOTIFY_SNOOZE_MINS=10

export BASAL_RENDER=default

export BRIDGE_USER_NAME=
export BRIDGE_PASSWORD=
export BRIDGE_INTERVAL=150000
export BRIDGE_MAX_COUNT=1
export BRIDGE_FIRST_FETCH_COUNT=3
export BRIDGE_MAX_FAILURES=3
export BRIDGE_MINUTES=1400

export MMCONNECT_USER_NAME=
export MMCONNECT_PASSWORD=
export MMCONNECT_INTERVAL=60000
export MMCONNECT_MAX_RETRY_DURATION=32
export MMCONNECT_SGV_LIMIT=24
export MMCONNECT_VERBOSE=false
export MMCONNECT_STORE_RAW_DATA=false

export DEVICESTATUS_ADVANCED="true"

export PUMP_ENABLE_ALERTS=true
export PUMP_FIELDS="reservoir battery clock status"
export PUMP_RETRO_FIELDS="reservoir battery clock"
export PUMP_WARN_CLOCK=30
export PUMP_URGENT_CLOCK=60
export PUMP_WARN_RES=40
export PUMP_URGENT_RES=10
export PUMP_WARN_BATT_P=20
export PUMP_URGENT_BATT_P=10
export PUMP_WARN_BATT_V=1.35
export PUMP_URGENT_BATT_V=1.30

export OPENAPS_ENABLE_ALERTS=true
export OPENAPS_WARN=30
export OPENAPS_URGENT=60
export OPENAPS_FIELDS="status-symbol status-label iob meal-assist rssi freq"
export OPENAPS_RETRO_FIELDS="status-symbol status-label iob meal-assist rssi"

export LOOP_ENABLE_ALERTS=false
export LOOP_WARN=30
export LOOP_URGENT=60

export SHOW_PLUGINS="careportal direction bage iob cob cage sage iage bwg rawbg basal bwp timeago devicestatus errorcodes boluscalc food delta profile focusHours"
export SHOW_FORECAST="ar2 openaps"

export LANGUAGE=de
export SCALE_Y=log
export EDIT_MODE=on


npm start
