# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class TalkChannel < ApplicationCable::Channel
  def subscribed
    talk = Talk.find(params[:id])
    stream_for talk
  end

  def unsubscribed
    p "TalkChannel unsubscribed #{params}"
  end

  def say(data)
    talk = Talk.find(params[:id])
    user = User.find(data['user_id'])
    res = talk.add_message(data, user)
    TalkChannel.broadcast_to(talk, res)
  end
end
