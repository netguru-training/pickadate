//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require_self
//= require_tree

$( document ).ready(function(){
    $("#event_participants_btn").click(function(event) {
        event.preventDefault();
        var $event_participants_form = $("#event_participants");
        var event_participants_avaibility = $event_participants_form.find(":checkbox");

        var dataToSend = $.map(event_participants_avaibility, function(element) {
            return ($(element).prop('checked')) ? 1 : 0;
        });

        $event_participants_form.append($('<input>').attr('type', 'hidden').attr('name', 'users_event[avaibility]').val(dataToSend));
        $event_participants_form.submit();
    });
});

