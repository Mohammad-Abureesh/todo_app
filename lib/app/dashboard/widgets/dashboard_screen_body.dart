import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/dashboard/widgets/search_field.dart';
import 'package:todo_app/core/constants/locale_keys.dart';
import 'package:todo_app/core/presentation/style/palette.dart';
import 'package:todo_app/core/presentation/widgets/build_text.dart';

import '/app/dashboard/controller/dashboard_screen_controller.dart';
import '/core/presentation/widgets/loading_widget.dart';
import '/core/utils/controllers_helpers.dart';
import 'tasks_list_view.dart';

class DashboardScreenBody extends StatelessWidget {
  final DashboardScreenController _controller;

  DashboardScreenBody({Key? key})
      : _controller = ControllersHelpers.inject(DashboardScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(() {
          return _controller.loader.isLoading.value
              ? const LoadingWidget()
              : Column(
                  children: [
                    SearchField(
                        hint: LocaleKeys.taskSearchHint,
                        controller: _controller.searchController,
                        onSearch: _controller.onSearch),
                    _TagsFilter(
                        activeTag: _controller.selectedTag,
                        other: _controller.otherTags,
                        onSelectTag: _controller.onSelectTag),
                    const Divider(color: Palette.white),
                    Expanded(
                      child: TasksListView(
                          tasks: _controller.tasks,
                          emptyState: _controller.tasks.isEmpty,
                          onUpdateState: _controller.setTaskState,
                          onFindCategory: _controller.onFindCategory),
                    ),
                  ],
                );
        }));
  }
}

class _TagsFilter extends StatelessWidget {
  final String _activeTag;
  final List<String> other;

  final void Function(String) onSelectTag;

  ///Default active tag [ALL]
  const _TagsFilter(
      {Key? key,
      required this.onSelectTag,
      required this.other,
      String? activeTag})
      : _activeTag = activeTag ?? LocaleKeys.all,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final tags = [LocaleKeys.all, LocaleKeys.today, ...other];
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: tags.map(_tagBuilder).toList()));
  }

  Widget _tagBuilder(String tag) {
    bool active = _activeTag == tag;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: ButtonStyle(
              side: MaterialStatePropertyAll(BorderSide(
                  color: active ? Palette.mainColor : Palette.hint))),
          onPressed: () {
            if (active) return;
            onSelectTag.call(tag);
          },
          child: BuildText(
              data: tag,
              fontSize: 14.0,
              color: active ? Palette.mainColor : null),
        ));
  }
}
