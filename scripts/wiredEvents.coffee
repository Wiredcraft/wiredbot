# Description
#   <description of the scripts functionality>
#
# Dependencies:
#   None
#
# Configuration:
#  None
#
# Commands:
#   hubot we lunched - info hubot either we are in lunching for already lunched
#
# Notes:
#   None
#
# Author:
#    wiredcraft

module.exports = (robot) ->
    # .
    robot.brain.on 'save', (data) ->
        dailyEvents = robot.brain.data['dailyEvents'] or= {}

        # .
        year = (new Date).getFullYear()
        month = (new Date).getMonth()
        day = (new Date).getDay()
        hours = (new Date).getHours()

        today = "#{year}-#{month}-#{day}"
        console.log today

        if dailyEvents['date'] is today
            unless dailyEvents['lunched']
                if day < 5 and 13 <= hours < 14
                  robot.messageRoom("internal@conference.chat.wiredcraft.com", 'lunch?')
                else
                  robot.messageRoom("internal@conference.chat.wiredcraft.com", "not hungry?")
        else
            robot.logger.debug "Today is #{today}"

    # .
    robot.respond /we[ ]+lunched$/i, (res) ->
        dailyEvents = robot.brain.data['dailyEvents'] or {}

        dailyEvents['lunched'] = true

        robot.brain.data['dailyEvents'] = dailyEvents

        res.send "Have a good time"

        res.finish()