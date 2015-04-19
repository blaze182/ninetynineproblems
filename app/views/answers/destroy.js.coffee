<% if @answer.errors.present? %>
$('.alert').html('<%= j @answer.errors.full_messages.to_sentence %>')
<% else %>
$('#<%=dom_id(@answer)%>').html('<%= j render "shared/deleted", entity: "answer" %>')
<% end %>
