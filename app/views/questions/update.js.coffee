<% if @question.errors.present? %>
$('.question-errors').html('<%= j @question.errors.full_messages.to_sentence %>')
<% else %>
$('.question-errors').html('')
$(".question-content h3").html('<%= j @question.title %>')
$(".question-body").html('<%= j @question.body %>')
$('#flashes').html('<%= j render "shared/flash" %>')
$(".question-edit-form").removeClass('fadeInUp').addClass('fadeOutUp').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
          $(this).addClass('hidden')
          $(".question-content").removeClass('hidden fadeOutUp').addClass('show animated fadeInUp')
          $(".question-edit-button").removeClass('disabled')
        )
<% end %>
