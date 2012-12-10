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
#   hubot remember the <key> of <user> is <value>
#   hubot forget me | <user>
#   hubot forget my <key>
#   hubot recall me | <user>
#   hubot recall my <key>
#   hubot recall the <key> of <user>
#
# Author:
#   wiredcraft

Util = require 'util'

rememberProfileItem = (robot, res, user, rawKey, rawValue) ->
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

forgetProfile = (robot, res, user) ->
  unless robot.brain.data.users[user]
    res.send "Who is #{user}?"
  unless robot.brain.data.users[user]['profile']
    res.send "#{user} dose not has profile"
  else
    delete robot.brain.data.users[user]['profile']

    res.send 'Why make me like human?'

  res.finish()

forgetProfileItem = (robot, res, user, rawKey) ->
  key = rawKey.trim().replace(/(\ )+/i, '-')

  unless robot.brain.data.users[user]
    res.send "Who is #{user}?"
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
    response = "Profile:\n"

    for key, value of profile
      rawKey = key.replace(/-/i, ' ')
      response += "#{rawKey} is #{value}\n"

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
      response = "#{rawKey} is #{value}"
      res.send response

  res.finish()

module.exports = (robot) ->
  # To remember
  # remember my <key> is <value>
  robot.respond /remember(\ )+my(\ )+(.*)(\ )+is(\ )+(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[3]
    rawValue = res.match[6]

    rememberProfileItem robot, res, user, rawKey, rawValue

  # remember <user>'s <key> is <value>
  robot.respond /remember(\ )+(\w+)'s(\ )+(.*)(\ )+is(\ )+(.*)/i, (res) ->
    user = res.match[2]
    rawKey = res.match[4]
    rawValue = res.match[7]

    rememberProfileItem robot, res, user, rawKey, rawValue

  # remember the <key> of <user> is <value>
  robot.respond /remember(\ )+the(\ )+(.*)(\ )+of(\ )+(\w+)(\ )+is(\ )+(.*)/i, (res) ->
    user = res.match[5]
    rawKey = res.match[2]
    rawValue = res.match[8]

    rememberProfileItem robot, res, user, rawKey, rawValue


  # To forget
  # forget me/<user>
  robot.respond /forget(\ )+(\w+)/i, (res) ->
    rawUser = res.match[2].trim()

    if rawUser is 'me' then user = res.message.user.name else user = rawUser

    forgetProfile robot, res, user

  # forget my <key>
  robot.respond /forget(\ )+my(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[2]

    forgetProfileItem robot, res, user, rawKey

  # forget the <key> of <user>
  robot.respond /forget(\ )+the(\ )+(.*)(\ )+of(\ )+(\w+)/i, (res) ->
    user = res.match[5]
    rawKey = res.match[2]

    forgetProfileItem robot, res, user, rawKey


  # To recall
  # recall me/<user>
  robot.respond /recall(\ )+(\w+)/i, (res) ->
    rawUser = res.match[2].trim()
    if rawUser is 'me' then user = res.message.user.name else user = rawUser

    recallProfile robot, res, user

  # recall my <key>
  robot.respond /recall(\ )+my(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[2]

    recallProfileItem robot, res, user, rawKey

  # recall the <key> of <user>
  robot.respond /recall(\ )+the(\ )+(.*)(\ )+of(\ )+(\w+)/i, (res) ->
    user = res.match[5]
    rawKey = res.match[2]

    recallProfileItem robot, res, user, rawKey