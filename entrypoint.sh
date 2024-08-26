#!/bin/bash

if [ $@ == "uvicorn" ]
    then
        exec $@ vpn_api.main:app --workers $WORKER --host $HOST --port $PORT
    else
    exec $@
fi
