$(document).ready ->
  updatePreview = ->
    $('#richbody').html($('#richTextField').contents().find("body").html())

  $(".btn").on 'click', (event) ->
    console.log(event.target.id)
    switch event.target.id
      when "undo"
        richTextField.document.execCommand('redo')
        updatePreview()
      when "redo"
        richTextField.document.execCommand('undo')
        updatePreview()
      when "bold"
        richTextField.document.execCommand('bold', false, null)
        updatePreview()
      when "underline"
        richTextField.document.execCommand('underline', false, null)
        updatePreview()
      when "italic"
        richTextField.document.execCommand('italic', false, null)
        updatePreview()
      when "link"
        linkURL = prompt("enter the URL for this link then", "http//")
        richTextField.document.execCommand('CreateLink', false, linkURL)
        updatePreview()
      when "unlink"
        richTextField.document.execCommand('Unlink', false, null)
        updatePreview()
      when "align-left"
        richTextField.document.execCommand('justifyLeft')
        updatePreview()
      when "align-right"
        richTextField.document.execCommand('justifyRight')
        updatePreview()
      when "align-center"
        richTextField.document.execCommand('justifyCenter')
        updatePreview()
      when "justify"
        richTextField.document.execCommand('justifyFull')
        updatePreview()
      when "pgbreak"
        richTextField.document.execCommand('inserthorizontalrule', false, null)
        updatePreview()
      when "ulist"
        richTextField.document.execCommand('insertUnorderedList', false, "newOL")
        updatePreview()
      when "olist"
        richTextField.document.execCommand('insertOrderedList', false, "newUL")
        updatePreview()
      when "addimage"
        document.getElementById("image-pop").style.display = "block"
        $("#imgsrc").focus()
      when "addmedia"
        embedHtml = prompt("post your embed text", "here")
        richTextField.document.execCommand('insertHtml', false, embedHtml)
        updatePreview()

  $("#newimage").on "click", ->
    imgSrc = document.getElementById("imgsrc").value
    imgHeight = document.getElementById("imgheight").value
    imgFloat = ""
    select = document.getElementById("alignment")
    selectValue = select.options[select.selectedIndex].value
    if selectValue == "left"
      imgFloat = "imgleft"
    else if selectValue == "right"
      imgFloat = "imgright"
    else
      imgFloat = " "

    imgEmbed = "<img id='myImage' src=\"#{imgSrc}\" height=\"#{imgHeight}\" class=\"#{imgFloat}\" />"
    richTextField.document.execCommand('insertHtml', false, imgEmbed)
    document.getElementById("imgsrc").value = ""
    document.getElementById("imgheight").value = ""
    $("#alignment").val('not set')
    document.getElementById("image-pop").style.display = "none"
    updatePreview()


  $("#closeimage").on "click", ->
    document.getElementById("image-pop").style.display = "none"

  $("select#format-select").change ->
    check = $('option:selected',$(this)).index()
    switch (check)
      when 1
        richTextField.document.execCommand('formatBlock', false, 'div')
        updatePreview()
      when 2
        richTextField.document.execCommand('formatBlock', false, 'h1')
        updatePreview()
      when 3
        richTextField.document.execCommand('formatBlock', false, 'h2')
        updatePreview()
      when 4
        richTextField.document.execCommand('formatBlock', false, 'h3')
        updatePreview()
      when 5
        richTextField.document.execCommand('formatBlock', false, 'h4')
        updatePreview()
      when 6
        richTextField.document.execCommand('formatBlock', false, 'h5')
        updatePreview()
      when 7
        richTextField.document.execCommand('formatBlock', false, 'p')
        updatePreview()

  $("#submit-form").on "click", ->
    Collection = document.getElementsByName("myForm")
    for thing in Collection
      theForm = thing
    $("#myTextArea").val($('#richTextField').contents().find("body").html())
    theForm.submit()
