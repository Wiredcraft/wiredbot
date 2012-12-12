# Description:
#   The dayly lie in  wiredcraft.
#
# Version
#   0.1.0a
#
# Commands:
#   hubot when is lunch time - Lunch time.
#   hubot where to go lunch - Alway to malatang.
#
# Author:
#   wiredcreaft

# ## Restaurants
RESTAURANTS = [
    "麻辣烫"
   ,"东北饺子"
   ,"麻辣火锅"
   ,"肯德基"
   ,"避风塘"
   ,"麦当劳"
   ,"面"
   ,"汤包"
]

# ## Listeners
module.exports = (robot) ->
  # ### Respond
  # Randomly return a restaurant from the list
  robot.respond /where to go lunch/i, (res) ->
    res.send res.random RESTAURANTS

    res.finish()

  # Ramdomlu pick up on item for a given list
  robot.respond /choose[ ]+one[ ]from[ ]+(.*)/i, (res) ->
    list = res.match[1].split ' '

    res.send res.random list

    res.finish()