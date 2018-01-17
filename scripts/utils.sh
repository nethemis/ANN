#!/bin/bash
# Bash utility methods

# Check whether a named process is running
function is_running () {
    pgrep "$1" > /dev/null
}

# Print fancy text
function print () {
    echo -e "🎃  \033[0;38;5;208m$1\033[0m"
}

function warning () {
    echo -e "🚨  \033[0;38;5;196m$1\033[0m"
}

function question () {

    # Define variables
    question="$1"
    default="${2:-n}"
    options="$(echo "y/n" | sed "s/$default/[$default]/g")"

    # Prompt response
    print "$question ($options) \c"
    read raw_response

    # Format responce as single lower-case character
    response=${raw_response:-$default}
    response=${response:0:1}
    response="$(echo "$response" | awk '{print tolower($0)}')"

    # Return numeric value
    if   [ "$response" == "y" ]; then
        return 1
    elif [ "$response" == "n" ]; then
        return 0
    else
        print "Response '$raw_response' not recognised. Using default value '$default'."
        if   [ "$default" == "y" ]; then
            return 1
        else
            return 0
        fi
    fi
}
