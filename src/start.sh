#!/bin/bash
echo '--- Starting Functions emulator ---'
functions start --host 0.0.0.0 --bindHost 0.0.0.0 <<EOF
functionstest
EOF
echo '--- Deploying trackGET ---'
functions deploy trackGET --trigger-http
echo '--- Deploy complete ---'

sleep 15    # keep the container alive so tests can run
