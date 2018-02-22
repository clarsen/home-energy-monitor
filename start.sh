#!/bin/sh
cd `dirname $0`
./ngrok  http --bind-tls=true 80
