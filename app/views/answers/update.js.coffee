<% if @answer.errors.present? %>
$('#<%=dom_id(@answer)%> .answer-errors').html('<%= j @answer.errors.full_messages.to_sentence %>')
<% else %>
$('#<%=dom_id(@answer)%> .answer-errors').html('')
# $('#<%=dom_id(@answer)%>_body').val('')
# $('#<%=dom_id(@answer)%>').html('<%= j render "answers/answer", answer: @answer, id: @answer.id %>')
$("#<%=dom_id(@answer)%> .answer-body").html('<%= j @answer.body %>')
$('#flashes').html('<%= j render "shared/flash" %>')
$("#<%=dom_id(@answer)%> .answer-edit-form").removeClass('fadeInUp').addClass('fadeOutUp').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
          $(this).addClass('hidden')
          $("#<%=dom_id(@answer)%> .answer-body").removeClass('hidden fadeOutUp').addClass('show animated fadeInUp')
          $("#<%=dom_id(@answer)%> .answer-edit-button").removeClass('disabled')
        )

<% end %>
