<% if @answer.errors.present? %>
$('.answer-errors').html('<%= j @answer.errors.full_messages.to_sentence %>')
<% else %>
$('.answer-errors').html('')
$('#answer_body').val('')
$('#answers').append('<%= j render "answers/answer", answer: @answer, id: @answer.id %>')
$('#flashes').html('<%= j render "shared/flash" %>')
<% end %>
