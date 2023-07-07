#!/usr/bin/env bash

set -a
GEONODE_SRC=/opt/geonode-3.3.x

load_env(){
    source $HOME/venv/geonode-3.3.x/bin/activate
    source $GEONODE_SRC/escape_env.sh
    escape_env $GEONODE_SRC/.env_wsgi && set -a && source $GEONODE_SRC/.env_wsgi && unescape_env $GEONODE_SRC/.env_wsgi
}

get_json_new_layer(){
    'Content-Type': 'application/json'

    "name": "poi",
    "nativeName": "poi",
    "title": "Manhattan (NY) points of interest",
    "abstract": "Points of interest in New York, New York (on Manhattan). One of the attributes contains the name of a file with a picture of the point of interest.",
      "srs": "EPSG:4326",

    "latLonBoundingBox": {
        "minx": -180,
        "maxx": 180,
        "miny": -90,
        "maxy": 90,
        "crs": "EPSG:4326"
    },


}

update_geoserver(){
    REQUEST_URL="rest/workspaces/geonode/datastores/geonode_data/featuredlayers.json"

    curl -XPOST -d'' --user "admin:${GEOSERVER_ADMIN_PASSWORD}" ${GEOSERVER_PUBLIC_LOCATION}/${REQUEST_URL}
}


update_geonode(){

    load_env
    python3 manage.py updatelayers -u admin -w geonode -f ${LAYER}
}

LAYER=${1?missing name of layer}

update_geonode
