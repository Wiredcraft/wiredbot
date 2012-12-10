# Description
#   Store personal profile in hubot's brain, then later we can use it.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot remember my <key> is <value>
#   hubot remember <user>'s <key> is <value>
#   hubot remember <key> of <user> is <value>
#
#   hubot forget my <key>
#   hubot recall <user>
#   hubot recall my <key>
#   hubot recall <key> of <user>
#
# Author:
#   wiredcraft

Util = require 'util'

rememberProfile = (robot, res, user, rawKey, rawValue) ->
  key = rawKey.trim().replace(/(\ )+/, '-')
  value = rawValue.trim()
  users = robot.brain.data.users

  unless users[user]
    res.send "Who is #{user}?"
  else
    profile = users[user]['profile'] or {}
    profile[key] = value

    users[user]['profile'] = profile
    robot.brain.data.users = users

    res.reply "Ok, #{rawKey} of #{user} is #{rawValue}"

  res.finish()

forgetProfile = (robot, res, user, rawKey) ->
  key = rawKey.trim().replace(/(\ )+/i, '-')

  unless robot.brain.data.users[user]
    res.send "Who is ${user}?"
  unless robot.brain.data.users[user]['profile']
    res.send "#{user} dose not has profile"
  else
    profile = robot.brain.data.users[user]['profile']

    delete profile[key]
    delete robot.brain.data.user[user]['profile'] unless profile

    res.send 'Why make me like human?'

  res.finish()

recallProfile = (robot, res, user) ->
  unless robot.brain.data.users[user]
    res.send "Who is #{user}?"
  unless robot.brain.data.users[user]['profile']
    res.send "#{user} dose not has profile"
  else
    profile = robot.brain.data.users[user]['profile']
    response = "Profiles:\n"

    for key, value of profile
      response += "#{key} is #{value}\n"

    res.send response

  res.finish()

recallProfileItem = (robot, res, user, rawKey) ->
  key = rawKey.trim().replace(/(\ )+/i, '-')

  unless robot.brain.data.users[user]
    res.send "Who is #{user}?"
  unless robot.brain.data.users[user]['profile']
    res.send "#{user} dose not has profile"
  else
    profile = robot.brain.data.users[user]['profile']
    value = profile[key]

    unless value
      res.send "#{user} dose not has #{key}"
    else
      response = "#{key} is #{value}"
      res.send response

  res.finish()

module.exports = (robot) ->
  # To remember
  robot.respond /remember(\ )+my(\ )+(.*)(\ )+is(\ )+(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[3]
    rawValue = res.match[6]

    console.log '############## #'
    rememberProfile robot, res, user, rawKey, rawValue

  robot.respond /remember(\ )+(\w+)'s(\ )+(.*)(\ )+is(\ )+(.*)$/i, (res) ->
    user = res.match[2]
    rawKey = res.match[4]
    rawValue = res.match[7]

    rememberProfile robot, res, user, rawKey, rawValue

  robot.respond /remember(\ )+(.*)(\ )+of(\ )+(\w+)(\ )+is(\ )+(.*)$/i, (res) ->
    user = res.match[5]
    rawKey = res.match[2]
    rawValue = res.match[8]

    rememberProfile robot, res, user, rawKey, rawValue


  # To forget
  robot.respond /forget(\ )+(.*)(\ )+of(\ )+(\w+)*$/i, (res) ->
    user = res.match[5]
    rawKey = res.match[2]

    forgetProfile robot, res, user, rawKey


  # To recall
  robot.respond /recall(\ )+(\w+)*$/i, (res) ->
    user = res.match[2]

    recallProfile robot, res, user

  robot.respond /recall(\ )+my(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[2]

    recallProfileItem robot, res, user, rawKey

  robot.respond /recall(\ )+(.*)(\ )+of(\ )+(\w+)*$/i, (res) ->
    user = res.match[5]
    rawKey = res.match[2]

    recallProfileItem robot, res, user, rawKey