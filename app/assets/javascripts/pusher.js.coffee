$ ->

  $('body').on('click', '#new-images', ()->
    $(this).hide()
  )
  $body = $('body')
  pusher_key = $body.data('pusher-key')
  if pusher_key
    $.getScript 'https://d3dy5gmtp8yhk7.cloudfront.net/2.2/pusher.min.js', ->
      pusher = new Pusher(pusher_key, cluster: $body.data('pusher-cluster'))
      channel = pusher.subscribe('event')
      channel.bind 'new-image', ->
        $('#new-images').show()
        $.get window.location, (data)->
          selector = ".images[data-event='#{"event"}']"
          $(selector).replaceWith($(data).find(selector).parent().html())

