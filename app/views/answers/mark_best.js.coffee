$("#answers").addClass('animated fadeInUp').html('<%= j render @question.answers %>')
$(document).trigger("page:update")
$("#answers").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
  $(this).removeClass('animated fadeInUp')
)
