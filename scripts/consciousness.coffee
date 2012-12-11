# Description
#   What if hubot has its own consciousness?
#
#  Version
#    0.1.0a
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot learn <name> - load a new script
#
# Notes:
#    None
#
# Author:
#    wiredcraft

Path = require 'path'
SCRIPTS_LIB = Path.resolve __dirname, '../node_modules/hubot-scripts/src/scripts'

# ## Listeners
module.exports = (robot) ->
    # Load a new script from scripts library.
    robot.respond /learn\ (\w+)*/i, (msg) ->
        name = msg.match[1].trim()
        if Path.extname(name) then (sctrip = name) else (script = name + 'coffee')

        scriptPath = Path.join SCRIPTS_LIB, script

        Path.exists scriptPath, (exists) ->
            unless exists
                msg.send """
                         Script #{name} not found at #{scriptPath}.
                         You can find all scripts at http://hubot-script-catalog.herokuapp.com/.
                         Some of them might not been working here through.
                         """
            else
                # TODO: add error handling?
                robot.loadFile SCRIPTS_LIB, name

                msg.send "Now I know how to do #{name}"