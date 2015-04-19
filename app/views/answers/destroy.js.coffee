<% if @answer.errors.present?
  flash[:error] = @answer.errors.full_messages.to_sentence
%>
$('#flashes').html('<%= j render "shared/flash" %>')
<% else %>
$('#<%=dom_id(@answer)%>').html('<%= j render "shared/deleted", entity: "answer" %>')
<% end %>
