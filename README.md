# setup
    pipenv --three
    # Get ngrok from https://ngrok.com/download
    # install influxdb
    # install grafana
    # install python-nest
    # install PyYAML
    # install arrow
    # install sense_energy
    # Add crontab.pi to pi's crontab
    git clone https://github.com/clarsen/RainEagle.git
    git clone https://github.com/clarsen/ruuvitag-sensor.git
    git clone https://github.com/clarsen/nest-to-influx.git
    git clone https://github.com/clarsen/sense-to-influx.git
    cd RainEagle
      pipenv run python setup.py install

    # go to wunderground-to-influx/ and follow README

# startup
    tmux
    ./start.sh  (to start ngrok so grafana can be accessed remotely)
