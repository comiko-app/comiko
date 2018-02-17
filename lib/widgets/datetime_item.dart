import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class DateTimeItem extends StatelessWidget {
  DateTimeItem({
    @required this.onChanged,
    Key key,
    DateTime dateTime,
  })
      : assert(onChanged != null),
        date = new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return new DefaultTextStyle(
      style: theme.textTheme.subhead,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: theme.dividerColor))),
              child: new InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: date.subtract(const Duration(days: 30)),
                          lastDate: date.add(const Duration(days: 30)))
                      .then<Null>((value) {
                    if (value != null)
                      onChanged(new DateTime(value.year, value.month, value.day,
                          time.hour, time.minute));
                  });
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(new DateFormat('yyyy-MM-dd').format(date)),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
