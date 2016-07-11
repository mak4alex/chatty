$(document).on 'turbolinks:visit', ->
  if App.talk
    App.talk.unsubscribe()
    console.log('unsubscribe')

$(document).on 'turbolinks:load', ->
  talk_id = $('#talk').data('talk-id')
  status = $('#talk').data('user-status')
  
  if status == 'banned'
    $('#message_submit').prop('disabled', true)
    alert("Error 403: You are banned!")

  if talk_id 
    App.talk = App.cable.subscriptions.create { channel: "TalkChannel", id: talk_id }, 
      connected: ->
        console.log('connected')
    
      disconnected: ->
        $('#message_submit').prop('disabled', true)
    
      received: (data) ->
        $('#messages').prepend(data)
        $('#no_records').hide()

      say: (body, user_id) -> 
        @perform 'say', body: body, user_id: user_id
