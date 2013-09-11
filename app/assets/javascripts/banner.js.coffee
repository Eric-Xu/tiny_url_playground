jQuery ->
  window.onblur = stopBanner
  window.onfocus = goBanner
  counter = 0

  goBanner = ->
    bnrInterval = setInterval ->
      loopData(counter)
      counter++
    , 5000

  stopBanner = ->
    window.clearInterval(bnrInterval)
    alert('blurred')

  loopData = (index) ->
    acronyms = [
      {key: 'a', value: 1},
      {key: 'b', value: 2},
      {key: 'c', value: 3}
    ]
    if index < acronyms.length
      replaceBanner(acronyms[index].key, acronyms[index].value)
    else
      counter = 0
      replaceBanner(acronyms[counter].key, acronyms[counter].value)

  replaceBanner = (acronym, definition) ->
    $('#bnr_acr').text(acronym)
    $('#bnr_def').text(definition)

  goBanner()