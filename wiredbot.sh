#!/usr/bin/env bash

# !!! KEEP THESE SECRET !!!
export PORT=9999
export HUBOT_XMPP_USERNAME="wiredbot@chat.wiredcraft.com"
export HUBOT_XMPP_PASSWORD=42
export HUBOT_XMPP_ROOMS="hubot@conference.chat.wiredcraft.com"
export HUBOT_XMPP_HOST="chat.wiredcraft.com"
export HUBOT_XMPP_PORT=5222
export HUBOT_XMPP_LEGACYSSL=1
#export HUBOT_XMPP_PREFERRED_SASL_MECHANISM=''
export HUBOT_AUTH_ADMIN="kuno@chat.wiredcraft.com"

exec sh ./bin/hubot --adapter xmpp --name wiredbot "$@"