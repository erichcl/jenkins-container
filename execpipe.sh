#!/bin/bash
CURRENT_FOLDER=`dirname "$0"`
while true; do eval "$(cat $CURRENT_FOLDER/pipes/jenkins.pipe)"; done