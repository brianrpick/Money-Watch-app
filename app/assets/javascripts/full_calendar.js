var initalize_calendar;
initalize_calendar = function() {
  var date_range_picker;
  date_range_picker = function() {
    $('.date-range-picker').each(function(){
    $(this).daterangepicker({
        timePicker: true,
        timePickerIncrement: 30,
        alwaysShowCalendars: true
    }, function(start, end, label) {
      $('.start_hidden').val(start.format('YYYY-MM-DD HH:mm'));
      $('.end_hidden').val(end.format('YYYY-MM-DD HH:mm'));
    });
  })
};
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
      expenseLimit: true,

      select: function(start, end) {
        $.getScript('/expenses/new', function() {
          $('#expense_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm")); date_range_picker();
          $('.start_hidden').val(moment(start).format("YYYY-MM-DD HH:mm"));
          $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });
        calendar.fullCalendar('unselect');
      },
      expenseDrop: function(expense, delta, revertFunc) {
        expense_data = {
          expense: {
            id: expense.id,
            start: expense.start.format(),
            end: expense.end.format()
          }
        };
        $.ajax({
            url: expense.update_url,
            data: expense_data,
            type: 'PATCH'
        });
      },
      
      expenseClick: function(expense, jsexpense, view) {
        $.getScript(expense.edit_url, function() {
          $('#expense_date_range').val(moment(expense.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(expense.end).format("MM/DD/YYYY HH:mm"));
          date_range_picker();
          $('.start_hidden').val(moment(expense.start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(expense.end).format('YYYY-MM-DD HH:mm'));
        });
      }
    });
  })
};
$(document).ready(function() {
  initalize_calendar();
});









