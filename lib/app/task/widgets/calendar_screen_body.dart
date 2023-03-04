import 'package:get/get.dart';
import 'package:todo_app/core/library/app_material.dart';
import 'package:todo_app/core/utils/app_utils.dart';
import 'package:todo_app/core/utils/controllers_helpers.dart';

import '/app/task/controllers/calendar_screen_controller.dart';

const int _emptyValue = -1;

class CalendarScreenBody extends StatelessWidget {
  final CalendarScreenController _controller;

  CalendarScreenBody({Key? key})
      : _controller = ControllersHelpers.inject(CalendarScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value
          ? const LoadingWidget()
          : Column(
              children: [
                const Space.vertical(40.0),
                const _CalenderDaysRow(),
                const Divider(color: Palette.lightGrey),
                _calendarViewsList,
              ],
            ),
    );
  }

  Widget get _calendarViewsList {
    final list = _controller.dates;
    if (list.isEmpty) return const EmptyList();

    return Expanded(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              return _CalenderView(
                date: list[index],
                inCheckPoint: _controller.inCheckPoint,
                onTap: _controller.onCheckPointPressed,
              );
            }));
  }
}

class _CalenderView extends StatelessWidget {
  final DateTime date;
  final InCheckPoint inCheckPoint;
  final CheckPointPressed onTap;

  const _CalenderView(
      {Key? key,
      required this.date,
      required this.inCheckPoint,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //number of days in month in [date]
    int daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);

    //to read date
    List<int> days = List.generate(daysInMonth, (index) => index + 1);

    //material localizations
    var localizations = MaterialLocalizations.of(context);

    //to get what is the first day in [date]
    final startFrom = DateUtils.firstDayOffset(
      date.year,
      date.month,
      localizations,
    );

    //calendar offset [-1] mean empty space
    days.insertAll(0, List.generate(startFrom - 1, (index) => -1));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Space.vertical(20.0),
          BuildText(data: '${AppUtils.monthName(date.month)} ${date.year}'),
          const Space.vertical(20.0),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 7,
            mainAxisSpacing: 40,
            crossAxisSpacing: 40,
            children: List.generate(days.length, (index) {
              final day = days.elementAt(index);
              if (day == _emptyValue) return const Space.empty();

              final checkPointDate = DateTime(date.year, date.month, day);
              bool hasCheckPoints = inCheckPoint.call(checkPointDate);

              return InkWell(
                onTap: hasCheckPoints ? () => onTap.call(checkPointDate) : null,
                child: CircleAvatar(
                    backgroundColor: hasCheckPoints
                        ? Palette.activeCheckPoint
                        : Colors.transparent,
                    child: BuildText(
                      data: '$day',
                      fontSize: 16.0,
                    )),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CalenderDaysRow extends StatelessWidget {
  const _CalenderDaysRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> days = AppUtils.dayOfWeek.keys.toList();

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map((e) => BuildText(data: AppUtils.dayAsString(e).toUpperCase()))
            .toList());
  }
}
