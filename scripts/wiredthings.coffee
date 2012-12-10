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
    robot.hear /(leave|leaving|bye)/i, (res) ->
        hours = (new Date).getHours()

        if hours >= 18
            res.reply 'Ok, your mom call you for dinner.'
        else
            res.reply 'Nooo, ronan will kill you!!!'

    # .
    robot.hear /lunch/i, (res) ->
        day = (new Date).getDay()
        hours = (new Date).getHours()

        if day >= 5
            res.reply 'Free is the breakfast'
        else
            if hours < 11
                res.reply 'When did you eat you breakfast?'
            if 11 < hours < 12
                res.reply 'Do you want a cup of coffee?'
            if 12 < hours < 13
                res.reply 'Call Christine...'
            if hours >= 13
                res.reply 'Perfect time'

    # .
    robot.respond /who am I/i, (res) ->
        user = res.message.user.name

        res.reply "eh?, u are #{user}, are user?"
