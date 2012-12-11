# Description
#   Store personal profile in hubot's brain, then later we can use it.
#
# Version:
#   0.1.0
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

# ## Internal Functions

# Remember one item of a user's profile
_rememberProfileItem = (robot, res, user, rawKey, rawValue) ->
  key = rawKey.trim().replace(/[ ]+/, '-')
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

# Forget the whole profile of a user
_forgetProfile = (robot, res, user) ->
  unless robot.brain.data.users[user]
    res.send "Who is #{user}?"
  unless robot.brain.data.users[user]['profile']
    res.send "#{user} dose not has profile"
  else
    delete robot.brain.data.users[user]['profile']

    res.send 'Why make me like human?'

  res.finish()

# Forgt one item from a user's profile
_forgetProfileItem = (robot, res, user, rawKey) ->
  key = rawKey.trim().replace(/[ ]+/i, '-')

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

# Recall the whole profile of a user
_recallProfile = (robot, res, user) ->
  unless robot.brain.data.users[user]
    res.send "Who is #{user}?"
  unless robot.brain.data.users[user]['profile']
    res.send "#{user} dose not has profile"
  else
    profile = robot.brain.data.users[user]['profile']
    response = "Profile of #{user}:\n"

    for key, value of profile
      rawKey = key.replace(/-/i, ' ')
      response += "#{rawKey} is #{value}\n"

    res.send response

  res.finish()

# Recall one item for a user's profile
_recallProfileItem = (robot, res, user, rawKey) ->
  key = rawKey.trim().replace(/[ ]+/i, '-')

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

# ## Listeners

module.exports = (robot) ->
  # ### To remember
  # Pattern: `remember my <key> is <value>`.
  robot.respond /remember[ ]+my[ ]+(.*)[ ]+is[ ]+(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[1]
    rawValue = res.match[2]

    _rememberProfileItem robot, res, user, rawKey, rawValue

  # Pattern: `remember <user>'s <key> is <value>`.
  robot.respond /remember[ ]+(\w+)'s[ ]+(.*)[ ]+is[ ]+(.*)/i, (res) ->
    user = res.match[1]
    rawKey = res.match[2]
    rawValue = res.match[3]

    _rememberProfileItem robot, res, user, rawKey, rawValue

  # Pattern: `remember the <key> of <user> is <value>`.
  robot.respond /remember[ ]+the[ ]+(.*)[ ]+of[ ]+(\w+)[ ]+is[ ]+(.*)/i, (res) ->
    user = res.match[1]
    rawKey = res.match[2]
    rawValue = res.match[3]

    _rememberProfileItem robot, res, user, rawKey, rawValue


  # ### To forget
  # Pattern: `forget me/<user>`.
  robot.respond /forget[ ]+(\w+)$/i, (res) ->
    rawUser = res.match[1].trim()
    user = if rawUser is "me" then res.message.user.name else rawUser

    _forgetProfile robot, res, user

  # Pattern: `forget my <key>`.
  robot.respond /forget[ ]+my(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[1]

    _forgetProfileItem robot, res, user, rawKey

  # Pattern: `forget the <key> of <user>`
  robot.respond /forget[ ]+the[ ]+(.*)[ ]+of[ ]+(\w+)/i, (res) ->
    rawKey = respond.match[1]
    user = res.match[2]

    _forgetProfileItem robot, res, user, rawKey


  # ### To recall
  # Pattern: `recall me/<user>`
  robot.respond /recall[ ]+(\w+)$/i, (res) ->
    rawUser = res.match[1].trim()
    user = if rawUser is "me" then res.message.user.name else rawUser

    _recallProfile robot, res, user

  # Pattern: `recall my <key>`
  robot.respond /recall[ ]+my(.*)/i, (res) ->
    user = res.message.user.name
    rawKey = res.match[1]

    _recallProfileItem robot, res, user, rawKey

  # Pattern: `recall the <key> of <user>`
  robot.respond /recall[ ]+the[ ]+(.*)[ ]+of[ ]+(\w+)/i, (res) ->
    rawKey = res.match[1]
    user = res.match[2]

    _recallProfileItem robot, res, user, rawKey