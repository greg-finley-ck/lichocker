#!/bin/bash
cd /home/lichess/projects/lila

whereis sbt
cd  /home/lichess/.sdkman/candidates/sbt/current/bin && ls -la
sbt sbtVersion

cd /home/lichess/projects/lila

# Run nginx.
sudo nginx

# Run MongoDB in the background.
sudo mongod --fork --logpath /var/log/mongod.log

# Install the GeoLite2 database if we haven't already.
if [ ! -e ./data/GeoLite2-City.mmdb ]; then
    ./bin/gen/geoip
fi

# Update the client side modules.
./ui/build

yarn install

# Run the Scala application
./lila run
