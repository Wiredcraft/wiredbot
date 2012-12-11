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
# Author
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
  # ### Events
  robot.brain.on 'save', (data) ->
    # Lunch notification
    day = (new Date).getDay()
    hours = (new Date).getHours()

    if day < 5 and 13 <= hours < 14
        robot.send {}, "Lunch?"
    else
        # TODO

  # ### Respond
  # Randomly return a restaurant from the list
  robot.respond /where to go lunch/i, (res) ->
    res.send res.random RESTAURANTS

    res.finish()