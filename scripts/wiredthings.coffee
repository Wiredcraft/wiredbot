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
        day = (new Date).getDay()
        hours = (new Date).getHours()

        if day < 5
            msg.send 'Free is the best'
        else
            if hours <= 11
                msg.send 'When did you eat you breakfast?'
            if 11 < hours <= 12
                msg.send 'Do you want a cup of coffee?'
            if 12 < hours <= 13
                msg.send 'Call Christine...'
            if hours > 13
                msg.send 'Perfect time'