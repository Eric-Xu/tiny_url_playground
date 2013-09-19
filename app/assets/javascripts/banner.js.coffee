jQuery ->
  storedIndex = $.cookie("acronym_index")
  counter = if storedIndex == null then 0 else storedIndex

  loopData = (index) ->
    acronyms = [
      {key: "BHAG",   value: "Big Hairy Audacious Goal"},
      {key: "MIC",    value: "Meanwhile, in Canada"},
      {key: "POTATO", value: "Person Over Thirty Acting Twenty One"},
      {key: "SNAG",   value: "Sensitive New Age Guy"},
      {key: "PU",     value: "That Stinks"},
      {key: "NSTLC",  value: "Need Some Tender Loving Care"},
      {key: "WIM",    value: "Woe Is Me"},
      {key: "POTUS",  value: "President of the United States"},
      {key: "FGDAI",  value: "Fuhgedaboudit"},
      {key: "MTFBWY", value: "May The Force Be With You"},
      {key: "EIP",    value: "Eggo Is Preggo"},
      {key: "WABOM",  value: "What A Bunch Of Malarkey"},
      {key: "TANSIT", value: "There's A New Sheriff In Town"},
      {key: "YAJWD",  value: "You Ain't Just Whistling Dixie"},
      {key: "VCDA",   value: "Vaya Con Dios, Amigo"} ]

    if index < acronyms.length
      updateText(acronyms[index].key, acronyms[index].value)
    else
      counter = 0
      updateText(acronyms[counter].key, acronyms[counter].value)

  updateText = (acronym, definition) ->
    $('#ring_acr').text(acronym)
    $('#ring_def').text(definition)

  initJSContent = ->
    $('#no_js_msg').removeClass('showing').addClass('hidden')
    $('#front_msg').removeClass('hidden').addClass('showing')

  toggleHidden = ->
    $('#ring_def').removeClass('hidden').addClass('showing')
    $('#rear_msg').removeClass('hidden').addClass('showing')
    $('#front_msg').removeClass('showing').addClass('hidden')

  resetContent = ->
    $('#ring_def').removeClass('showing').addClass('hidden')
    $('#rear_msg').removeClass('showing').addClass('hidden')
    $('#front_msg').removeClass('hidden').addClass('showing')

  $('#ring_rear').click ->
    window.setTimeout ->
      loopData(counter)
      resetContent()
    , 10000
    toggleHidden()
    counter++
    $.cookie("acronym_index", counter)

  initJSContent()
  loopData(counter)