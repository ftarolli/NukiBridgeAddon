#!/usr/bin/with-contenv bashio

FILE=/data/nuki.yaml

function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

echo "-----------------------------------------------------------"
echo "checking configuration file..."
echo "-----------------------------------------------------------"

if [ -f "$FILE" ]; then
    echo "configuration file already generated..."
    echo "-----------------------------------------------------------"
    eval $(parse_yaml $FILE "nuki_")
    echo ""
    echo "BRIDGE DATA:"
    echo "app_id: $nuki_server_app_id"
    echo "token: $nuki_server_token"
    echo ""
else 
    echo "generating configuration file..."

    python3 /opt/__main__.py --generate-config > $FILE

    echo "config file created..."
    echo "-----------------------------------------------------------"
    eval $(parse_yaml $FILE "nuki_")
    echo ""
    echo "BRIDGE DATA:"
    echo "app_id: $nuki_server_app_id"
    echo "token: $nuki_server_token"
    echo ""
fi

LOCK_MAC=$(bashio::config 'lock_MAC')
VERBOSE=$(bashio::config 'verbose')

if [ $nuki_server_paired = "true" ]; then
    echo "-----------------------------------------------------------"
    echo "lock already paired. Starting the server..."
    echo "-----------------------------------------------------------"

    if [ $VERBOSE >0 ]; then
        python3 /opt/__main__.py --config $FILE --verbose $VERBOSE
    else
        python3 /opt/__main__.py --config $FILE
    fi
else
    echo "-----------------------------------------------------------"
    echo "lock need to be paired. Starting pairing..."
    echo "-----------------------------------------------------------"
    if [ $VERBOSE >0 ]; then
        python3 /opt/__main__.py --pair $LOCK_MAC --config $FILE --verbose $VERBOSE
    else
        python3 /opt/__main__.py --pair $LOCK_MAC --config $FILE
    fi

    eval $(parse_yaml $FILE "nuki_")

    echo "-----------------------------------------------------------"
    echo "lock paired. Starting the server..."
    echo "-----------------------------------------------------------"
    
    if [ $VERBOSE >0 ]; then
        python3 /opt/__main__.py --config $FILE --verbose $VERBOSE
    else
        python3 /opt/__main__.py --config $FILE
    fi
fi


