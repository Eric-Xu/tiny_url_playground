jQuery ->
  counter = 0

  loopData = (index) ->
    acronyms = [
      {key: "BHAG",   value: "Big Hairy Audacious Goal"},
      {key: "MIC",    value: "Meanwhile, in Canada"},
      {key: "NSTLC",  value: "Need Some Tender Loving Care"},
      {key: "EIP",    value: "Eggo Is Preggo"},
      {key: "GIGO",   value: "Garbage In, Garbage Out"},
      {key: "SIP",    value: "Skiing In Powder"},
      {key: "GMTA",   value: "Great Minds Think Alike"},
      {key: "MLAS",   value: "My Lips Are Sealed"},
      {key: "TWSS",   value: "That's What She Said"},
      {key: "KB",     value: "Kick Butt"},
      {key: "HBB",    value: "Hip Beyond Belief"},
      {key: "VCDA",   value: "Vaya Con Dios, Amigo"} ]

    if index < acronyms.length
      updateText(acronyms[index].key, acronyms[index].value)
    else
      counter = 0
      updateText(acronyms[counter].key, acronyms[counter].value)

  updateText = (acronym, definition) ->
    $('#ring_acr').text(acronym)
    $('#ring_def').text(definition)

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