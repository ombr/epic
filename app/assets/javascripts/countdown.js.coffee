$ ->
  $('.countdown').each ->
    timestamp = $(this).data('timestamp')
    date = new Date(timestamp)
    console.log date
    $(this).countdown(until: date, layout: '{hn} {hl}, {mn} {ml}, {sn} {sl}')
