var initalize_calendar;
initalize_calendar = function() {

  $('#calendar-one').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/expenses.json',

      select: function(start, end) {
        $.getScript('/expenses/new', function() {
          $('.expense_date_range').val(moment(start).format("MM/DD/YYYY") + ' - ' + moment(end).format("MM/DD/YYYY")); date_range_picker();
          $('.start_hidden').val(moment(start).format("YYYY-MM-DD"));
          $('.end_hidden').val(moment(end).format('YYYY-MM-DD'));
        });
        calendar.fullCalendar('unselect');
      },
      eventDrop: function(expense, delta, revertFunc) {
        event_data = {
          expense: {
            id: expense.id,
            start: expense.start.format(),
            end: expense.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data["expense"],
            type: 'PATCH'
        });
      },
      
      eventClick: function(expense, jsexpense, view) {
        $.getScript(expense.edit_url, function() {
          $('#expense_date_range').val(moment(expense.start).format("MM/DD/YYYY") + ' - ' + moment(expense.end).format("MM/DD/YYYY"));
          date_range_picker();
          $('.start_hidden').val(moment(expense.start).format('YYYY-MM-DD'));
          $('.end_hidden').val(moment(expense.end).format('YYYY-MM-DD'));
        });
      }
      
    });
  })
};
$(document).ready(function() {
  initalize_calendar();
});









