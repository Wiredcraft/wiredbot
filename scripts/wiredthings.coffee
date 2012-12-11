# Description:
#   What well happen if hubot heard something in wiredcraft
#
# Version:
#    0.1.0a
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

Util = require 'util'

# ## Listeners
module.exports = (robot) ->
    # When someone praise.
    robot.respond ///
      ( thank
      | awesome
      | great
      | love
      | helpful
      | smarter
      | excellent
      | perfect
      | wonderful ) ///i, (res) ->
      word = res.match[1]
      res.reply 'You are welcome'

    # When someone blame.
    robot.respond ///
      ( stupid
      | useless
      | bad
      | asshole
      | fuck
      | suck ) ///i, (res) ->
      word = res.match[1]
      res.send "Which is more #{word}? human ro robots?"

    # When someone leaving.
    robot.hear ///
      ( leave
      | leaving
      | bye
      | need[ ]+to[ ]+go
      | must[ ]+go
      | must[ ]+leave
      | leave[ ]+earilier ) ///i, (res) ->
      word = res.match[1]
      hours = (new Date).getHours()

      if hours >= 18
        res.reply 'Ok, your mom call you for dinner.'
      else
        res.reply 'Nooo, ronan will kill you!!!'

    # When someone is hungry.
    robot.hear /^lunch/i, (res) ->
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

    # When someone was forget who is she/he. .
    robot.respond /who[ ]+(is|are|am)[ ]+(\w+)/i, (res) ->
        be = res.match[1]
        name = res.match[2]
        users = robot.brain.data.users

        switch be
          when 'are' then res.reply "I am your friend, #{robot.name}."
          when 'am' then res.reply "eh?, u are #{res.message.user.name}, are u?"
          when 'is'
            unless users[name]
              res.reply "I dont know anything about #{name}."
            unless users[name]['profile']
              res.reply "#{name} has not profile"
            else
              res.send Util.inspect(users[name]['profile'], false, 4)

        res.finish()