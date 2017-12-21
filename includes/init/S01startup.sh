#!/bin/bash

# Description: 
#	This is the entry point to startup the container.
#	The script will run all subsequent scripts labeled
#	S##*.sh with S99*.sh being the final script.

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

scripts=($BASE_DIR/S*.sh)
scripts=("${scripts[@]:1}")

# iterate through array using a counter
for ((i=0; i<${#scripts[@]}; i++)); do
    
    # If script is S99*, run it indefinitely.
    # Otherwise eval to get return code.
    if [[ ${scripts[$i]} == *"/S99"* ]]
    	then
    		echo "[INFO] Running app startup..."
    		/bin/bash ${scripts[$i]}
    else
    	eval /bin/bash ${scripts[$i]}
    	ret_code=$?
    fi
    
    # Stop execution if bad return code
    if [ $ret_code != 0 ]
    	then
    		echo "[ERROR] ${scripts[$i]} failed. Exit Code: $ret_code"
    		echo "[ERROR] Stopping execution..."
    		exit 1
    fi
done

exit 0
