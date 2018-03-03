import requests
import pprint
from influxdb import InfluxDBClient


data = requests.get('http://api.wunderground.com/api/<YOUR_API_KEY>/conditions/q/pws:<YOUR_NEARBY_PWS>.json').json()
#pprint.pprint(data)

client = InfluxDBClient(host="localhost", port=8086, database="ruuvi")

def convert_to_influx(data):
    json_body = []
    keymap = {
	'temp_c': 'temperature',
	'pressure_mb': 'pressure',
	'relative_humidity': 'humidity',
    }
    for wu_field, field in keymap.items():
        if field == 'pressure':
            value = float(data['current_observation'][wu_field]) * 100
        elif field == 'temperature':
            value = float(data['current_observation'][wu_field])
        elif field == 'humidity': 
            value = float(data['current_observation'][wu_field].strip('%'))
        else:
            raise RuntimeError("need to specify")
        json_body.append({
            "measurement": field,
            "tags": {
                "mac": data['current_observation']['station_id'],
            },
            "fields": {
                "value": value,
            }
        })

    return json_body


json_body = convert_to_influx(data)
print("would write",json_body)
#import sys
#sys.exit(0)

client.write_points(json_body)
