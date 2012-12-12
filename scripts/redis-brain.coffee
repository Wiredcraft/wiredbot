# Description:
#   None
#
# Dependencies:
#   "redis": "0.7.2"
#
# Configuration:
#   REDISTOGO_URL
#
# Commands:
#   None
#
# Author:
#   atmos

Url   = require "url"
Redis = require "redis"

# sets up hooks to persist the brain into redis.
module.exports = (robot) ->
  info   = Url.parse process.env.REDISTOGO_URL || 'redis://localhost:6379'
  client = Redis.createClient(info.port, info.hostname)

  if info.auth
    client.auth info.auth.split(":")[1]

  client.on "error", (err) ->
    robot.logger.error err

  client.on "connect", ->
    robot.logger.debug "Successfully connected to redis"

    client.get "hubot:storage", (err, reply) ->
      if err
        throw err
      else if reply
        robot.brain.mergeData JSON.parse(reply.toString())

        # .
        year = (new Date).getFullYear()
        month = (new Date).getMonth()
        day = (new Date).getDay()

        today = "#{year}-#{month}-#{day}"

        robot.logger.debug "Today is #{today}"

        dailyEvents = {} unless robot.brain.data['dailyEvents']?

        # Setup default daily event status
        if not dailyEvents['date'] or dailyEvents['date'] isnt today
          dailyEvents['date'] =
            date: today
            lunched: false
        else
          robot.logger.debug "The events of #{today} had already been setup"

        # .
        robot.brain.data['dailyEvents'] = dailyEvents

  robot.brain.on 'save', (data) ->
    client.set 'hubot:storage', JSON.stringify data

  robot.brain.on 'close', ->
    client.quit()
