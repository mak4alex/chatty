$(document).on 'turbolinks:load', ->
  $('#message_form').submit (e) ->
    e.preventDefault()
    user_id = $('#message_user_id').val()
    body = $('#message_body').val()
    $('#message_body').val('')
    App.talk.say(body, user_id) if body
    setTimeout ( ->
      $('#message_submit').prop('disabled', false)
    ), 100
      
    
  # Configure infinite messages
  $('.messages-wraper').infinitePages
    context: '.messages-wraper'
    loading: ->
      $(this).text('Loading messages...')
    error: ->
      $(this).button('Error, please try again')