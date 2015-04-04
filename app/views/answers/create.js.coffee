$('.notice').html('')
$('.alert').html('')
<% unless flash[:alert] %>
$('#answers').append('<%= j render "answers/answer", answer: @answer, id: @answer.id %>')
$('.notice').html('<%= flash[:notice] %>')
<% else %>
$('.alert').html('<%= flash[:alert] %>')
<% end %>