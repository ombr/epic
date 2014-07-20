$ ->
  $('.fileupload').each (i,e)->
    $form = $(e)
    $('input[type=submit]', $form).hide()
    $('input[type=file]', $form).attr('multiple', 'true').fileupload(
      dataType: 'xml',
      add: (event, file) ->
        $.getJSON '/images/new', (data)->
          file.formData = data
          file.submit()
      done: (event, data)->
        $.get('/images/add',
          { key: $(data.result).find('Key').text() },
          ->
            alert 'OK'
        )
    )

