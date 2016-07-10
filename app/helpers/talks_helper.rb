module TalksHelper
  
  def last_message_of(talk)
    last_message = talk.last_message
    body = last_message.present? ? last_message.body : 'There are no messages yet'
    content_tag :p, body
  end
  
end
