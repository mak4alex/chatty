$(document).on 'turbolinks:visit', ->
  if App.chat
    App.chat.unsubscribe()
    console.log('unsubscribe')

$(document).on 'turbolinks:load', ->
  talk_id = $('#talk').data('talk-id')
  if talk_id
    App.talk = App.cable.subscriptions.create { channel: "TalkChannel", id: talk_id }, 
      connected: ->
        $('#message_submit').prop('disabled', false)
    
      disconnected: ->
        $('#message_submit').prop('disabled', true)
    
      received: (data) ->
        console.log(data)
        if data.code == 201
          $('#message_submit').prop('disabled', false)
          $('#messages').prepend(data.body)
          $('#no_records').hide()
        else
          alert("Error #{data.code}: #{data.body}")
    
      say: (body, user_id) -> 
        @perform 'say', body: body, user_id: user_id
