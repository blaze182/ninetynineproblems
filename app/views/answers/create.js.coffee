<% if @answer.errors.present? %>
$('.answer-errors').html('<%= j @answer.errors.full_messages.to_sentence %>')
<% else %>
$('#answers').append('<%= j render "answers/answer", answer: @answer, id: @answer.id %>')
$('.notice').html('<%= j flash[:notice] %>')
<% end %>
