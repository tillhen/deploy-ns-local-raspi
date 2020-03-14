#!/bin/sh
cd /home/pi/cgm-remote-monitor

# Eine Beschreibung der Felder finden Sie unter https://github.com/nightscout/cgm-remote-monitor#environment
# Erforderlich für Nightscout, bitte bearbeiten

# Erforderlich für Nightscout
# Ihr Mongo Uri, zum Beispiel: mongodb: // sally: sallypass@ds099999.mongolab.com: 99999 / nightcout
# TODO: secure mongo collection with generated username / password
export MONGO_CONNECTION=
# export MONGO_CONNECTION=mongodb://localhost:27017/nightscout
# export CUSTOMCONNSTR_mongo=mongodb:mongodb://localhost:27017/nightscout
# export CUSTOMCONNSTR_mongo_collection=testcoll
export MONGO_COLLECTION=entries
export MONGO_TREATMENTS_COLLECTION=treatments
export MONGO_DEVICESTATUS_COLLECTION=devicestatus
export MONGO_PROFILE_COLLECTION=profile
export MONGO_FOOD_COLLECTION=food
export PROFILE_HISTORY=true
export PROFILE_MULTIPLE=true

export INSECURE_USE_HTTP=true
export API_SECRET="Passwort (12 Zeichen)"
# export AUTH_DEFAULT_ROLES=redable
export AUTH_DEFAULT_ROLES=denied

# Erforderlich für Nightscout
# BASE_URL. Wird zum Erstellen von Links zu Ihrer Site-API verwendet, z.B. Pushover-Rückrufe, normalerweise die URL Ihrer Nightscout-Site
export BASE_URL="http://'localhost':1337"

export HOSTNAME=0.0.0.0
export PORT=1337
# export SSL_KEY= Pfad zu Ihrer SSL-Schlüsseldatei, damit SSL (https) direkt in node.js aktiviert werden kann. Wenn Sie Let's Encrypt verwenden, nehmen Sie diese Variable zum Pfad zu Ihrer privkey.pem-Datei (privater Schlüssel).
# export SSL_CERT= Pfad zu Ihrer SSL-Zertifizierungsdatei, sodass SSL (https) direkt in node.js aktiviert werden kann. Wenn Sie Let's Encrypt verwenden, nehmen Sie diese Variable zum Pfad zur Datei fullchain.pem (cert + ca).
# export SSL_CA= Pfad zu Ihrer SSL-CA-Datei, sodass SSL (https) direkt in node.js aktiviert werden kann. Wenn Sie Let's Encrypt verwenden, nehmen Sie diese Variable zum Pfad zur Datei chain.pem (chain).

export ENABLE="avg bage basal bgi bgnow boluscalc bwp cage careportal cob cors delta devicestatus direction errorcodes food iage iob profile pump rawbg sage spech timeago treatments upbat"
export DISABLE="upbat simplealarms bridge mmconnect loop"

# DISPLAY_UNITS. Auswahlmöglichkeiten: mg/dl und mmol. Durch die Einstellung auf mmol wird der gesamte Server standardmäßig in den mmol-Modus versetzt, ohne dass weitere Einstellungen erforderlich sind.
export DISPLAY_UNITS=mmol
export TIME_FORMAT=24
export LANGUAGE=de
export SCALE_Y=log
export BASAL_RENDER=default

export BG_HIGH=200
export BG_TARGET_TOP=180
export BG_TARGET_BOTTOM=70
export BG_LOW=54

export ALARM_TIMEAGO_WARN=false
export ALARM_TIMEAGO_WARN_MINS=15
export ALARM_TIMEAGO_URGENT=true
export ALARM_TIMEAGO_URGENT_MINS=30
export Pump_Battery_Low=on

export NIGHT_MODE=off
export EDIT_MODE=on
export SHOW_RAWBG=always
export CUSTOM_TITLE="Mein NIGHTSCOUT"
export THEME=colors

export SHOW_PLUGINS="avg bage basal boluscalc bwp cage careportal cob cors direction devicestatus errorcodes iage iob food profile pump sage rawbg-on treatments focusHours"
export SHOW_FORECAST="ar2"

export ALARM_TYPES=predict
export TREATMENTNOTIFY_SNOOZE_MINS=10
export DEVICESTATUS_ADVANCED=true
export FOCUS_HOURS=6

export CAGE_ENABLE_ALERTS=false
export CAGE_INFO=60
export CAGE_WARN=72
export CAGE_URGENT=84
export CAGE_DISPLAY=days

export IAGE_ENABLE_ALERTS=false
export IAGE_INFO=72
export IAGE_WARN=96
export IAGE_URGENT=120

export SAGE_ENABLE_ALERTS=true
export SAGE_INFO=144
export SAGE_WARN=164
export SAGE_URGENT=168

export BAGE_ENABLE_ALERTS=false
export BAGE_INFO=204
export BAGE_WARN=210
export BAGE_URGENT=222

export BWP_WARN=1.00
export BWP_URGENT=1.50
export BWP_SNOOZE_MINS=10
export BWP_SNOOZE=0.10

export PUMP_ENABLE_ALERTS=true
export PUMP_FIELDS="reservoir battery clock status"
export PUMP_RETRO_FIELDS="reservoir battery clock status"
export PUMP_WARN_CLOCK=false
export PUMP_URGENT_CLOCK=false
export PUMP_WARN_RES=40
export PUMP_URGENT_RES=5
export PUMP_WARN_BATT_P=20
export PUMP_URGENT_BATT_P=10
export PUMP_WARN_BATT_V=1.35
export PUMP_URGENT_BATT_V=1.30

export OPENAPS_ENABLE_ALERTS=false
export OPENAPS_WARN=30
export OPENAPS_URGENT=60
export OPENAPS_FIELDS="status-symbol status-label iob meal-assist rssi freq"
export OPENAPS_RETRO_FIELDS="status-symbol status-label iob meal-assist rssi"

export ERRORCODES_WARN=true
export ERRORCODES_INFO="1 2 3 4 5 6 7 8 9"
export ERRORCODES_URGENT="9 10"

# export NODE_ENV=development
export NODE_ENV=production


npm start
