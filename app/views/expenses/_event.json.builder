date_format = expense.all_day_expense? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id expense.id
json.title expense.title
json.start expense.start.strftime(date_format)
json.end expense.end.strftime(date_format)

json.color expense.color unless expense.color.blank?
json.allDay expense.all_day_expense? ? true : false

json.update_url expense_path(expense, method: :patch)
json.edit_url edit_expense_path(expense)