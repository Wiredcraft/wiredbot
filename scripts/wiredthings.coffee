# Description
#   What well happen if hubot heard something within wiredcraft
#
# Dependencies:
#   None
#
# Configuration:
#  None
#
# Commands:
#    leave|leaving|bye- You can not go
#
# Notes:
#    None
#
# Author:
#   wiredcraft

module.exports = (robot) ->
    # .
    robot.hear /(leave|leaving|bye)/i, (msg) ->
        hours = (new Date).getHours()

        if hours > 19
            msg.send 'Ok, your mom call you for dinner.'
        else
            msg.send 'Nooo, ronan will kill you!!!'

    # .
    robot.hear /lunch/i, (msg) ->
        hours = (new Date).getHours()

        if hours <= 11
            msg.send '11'
        if 11 < hours <= 12
            msg.send '12'
        if 12 < hours <= 13
            msg.send '13'
        if hours > 13
            msg.send 'too late'