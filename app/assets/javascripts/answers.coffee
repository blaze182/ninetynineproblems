# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.answer-edit-button').click (e) ->
    e.preventDefault()
    $(this).addClass('disabled')
    answer_id = $(this).data('answerId')
    $("#answer_#{answer_id} .answer-body").removeClass('fadeInUp').addClass('animated fadeOutUp').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
          $(this).addClass('hidden')
          $("#answer_#{answer_id} .answer-edit-form").removeClass('hidden fadeOutUp').addClass('show animated fadeInUp')
        )

# turbolinks event handling
$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
