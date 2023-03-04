import 'package:get/get.dart';
import 'package:todo_app/core/applicationManagers/navigation_manager.dart';
import 'package:todo_app/core/library/app_material.dart';

typedef OnSelectDateTime = void Function(DateTime? date);

const Color _cardColor = Color(0xff272727);
const double _activeFontSize = 24.0;

RoundedRectangleBorder _shape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));

class DateTimePickerButton extends StatelessWidget {
  final OnSelectDateTime? onSelectDate;
  final String _icon;
  final DateTime? initDate;

  ///When you need to replace icon to custom widget
  final Widget? child;

  ///To open date time picker
  const DateTimePickerButton(
      {String? icon, Key? key, this.onSelectDate, this.initDate, this.child})
      : _icon = icon ?? IconsKeys.timer,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final initDate = this.initDate ?? DateTime.now();

    impl() async {
      var date = await NavigationManager.openDialog<DateTime?>(
          _DatePickerAlert(initDate: initDate));
      onSelectDate?.call(date);
    }

    Widget child = IconButton(
        onPressed: impl,
        icon: SvgIcon.defSize(icon: _icon, color: Palette.white));

    if (this.child != null) {
      child = InkWell(onTap: impl, child: this.child);
    }

    return child;
  }
}

class _DatePickerAlert extends StatefulWidget {
  final DateTime initDate;

  const _DatePickerAlert({Key? key, required this.initDate}) : super(key: key);

  @override
  State<_DatePickerAlert> createState() => _DatePickerAlertState();
}

class _DatePickerAlertState extends State<_DatePickerAlert> {
  bool _showTimePicker = false;

  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initDate;
    selectedTime = _initTimeOfDay;
  }

  void _showTime() {
    setState(() {
      _showTimePicker = true;
    });
  }

  TimeOfDay get _initTimeOfDay {
    return TimeOfDay(
      hour: widget.initDate.hour,
      minute: widget.initDate.minute,
    );
  }

  void _returnFinalResult() {
    final date = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    NavigationManager.back<DateTime?>(r: date);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      const Expanded(child: CancelButton()),
      _chooseTime,
    ];

    return AlertDialog(
        shape: _shape,
        content: SizedBox.fromSize(
          size: Size(330.0, _showTimePicker ? 235.0 : 430),
          child: Column(
            children: [
              if (_showTimePicker) ...[
                const BuildText(data: LocaleKeys.chooseTime),
                const Divider(color: Palette.white),
                const Space.vertical(30.0),
              ],
              _showTimePicker
                  ? _TimePicker(
                      initTime: _initTimeOfDay,
                      onTimeChanged: (TimeOfDay time) {
                        selectedTime = time;
                      })
                  : Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: Palette.mainColor,
                            onPrimary: Palette.white,
                            onSurface: Palette.white),
                        iconButtonTheme: IconButtonThemeData(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0))))),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.white, // button text color
                          ),
                        ),
                      ),
                      child: CalendarDatePicker(
                          initialDate: widget.initDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now()
                              .add(const Duration(days: 30 * 12 * 10)),
                          onDateChanged: (DateTime value) {
                            selectedDate = value;
                          }),
                    ),
              const Space.vertical(30.0),
              Row(children: actions)
            ],
          ),
        ));
  }

  Widget get _chooseTime {
    final title = _showTimePicker ? LocaleKeys.save : LocaleKeys.chooseTime;
    final impl = _showTimePicker ? _returnFinalResult : _showTime;
    return Expanded(child: BuildMainButton(title: title, onPressed: impl));
  }
}

//un complete time picker is still improvements
class _TimePicker extends StatelessWidget {
  final TimeOfDay initTime;
  final void Function(TimeOfDay) onTimeChanged;

  //To manage time picker state
  final RxInt _hour;
  final RxInt _minute;
  final RxString _period;

  _TimePicker({Key? key, required this.initTime, required this.onTimeChanged})
      : _hour = initTime.hourOfPeriod.obs,
        _minute = initTime.minute.obs,
        _period = initTime.period.name.obs,
        super(key: key);

  void _timeChangedCallBack() {
    onTimeChanged.call(TimeOfDay(hour: _hour.value, minute: _minute.value));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _hours,
        const BuildText(data: ':', fontSize: 30.0),
        _minuteCard,
        _amPm
      ],
    );
  }

  String _twoDigits(int value) {
    return '${value < 10 ? '0$value' : value}';
  }

  Widget get _hours {
    List<int> hours = List.generate(12, (index) => index + 1);
    return _WheelCard(
        initialItem: initTime.hour,
        onSelect: (int? index) {
          if (index == null) return;
          _hour.value = hours.elementAt(index);
          _timeChangedCallBack();
        },
        children: hours.map((h) {
          return Obx(() {
            return BuildText(
              data: _twoDigits(h),
              color: h == _hour.value ? Palette.white : Colors.white10,
              fontSize: h == _hour.value ? _activeFontSize : 16.0,
            );
          });
        }).toList());
  }

  Widget get _minuteCard {
    List<int> minutes = List.generate(61, (index) => index);
    return _WheelCard(
        initialItem: initTime.minute,
        onSelect: (int? index) {
          if (index == null) return;
          _minute.value = minutes.elementAt(index);
          _timeChangedCallBack();
        },
        children: minutes.map((m) {
          return Obx(() {
            return BuildText(
              data: _twoDigits(m),
              color: m == _minute.value ? Palette.white : Colors.white10,
              fontSize: m == _minute.value ? _activeFontSize : 16.0,
            );
          });
        }).toList());
  }

  Widget get _amPm {
    return _WheelCard(
        onSelect: (int? index) {
          if (index == null) return;
          _period.value = DayPeriod.values.elementAt(index).name;
          _timeChangedCallBack();
        },
        children: DayPeriod.values
            .map((e) => e.name)
            .map((e) => Obx(() {
                  return BuildText(
                    data: e.toUpperCase(),
                    fontSize: e == _period.value ? _activeFontSize : 18.0,
                    color: e == _period.value ? Palette.white : Colors.white10,
                  );
                }))
            .toList());
  }
}

class _WheelCard extends StatelessWidget {
  final void Function(int?) onSelect;
  final List<Widget> children;
  final int initialItem;

  const _WheelCard(
      {Key? key,
      required this.onSelect,
      required this.children,
      this.initialItem = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
        dimension: 90.0,
        child: Card(
            shape: _shape,
            color: _cardColor,
            child: ListWheelScrollView(
                controller:
                    FixedExtentScrollController(initialItem: initialItem),
                itemExtent: 30.0,
                perspective: 0.005,
                diameterRatio: 2,
                onSelectedItemChanged: onSelect,
                children: children)));
  }
}
