import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/extensions/date_time_ext.dart';

import '/core/constants/locale_keys.dart';
import '/core/enums/e_task_status.dart';
import '/core/presentation/controllers/base_controller.dart';
import '/core/presentation/controllers/loading_controller.dart';
import '/data/categories_services.dart';
import '/data/tasks_services.dart';
import '/domain/entities/category_entity.dart';
import '/domain/entities/task_entity.dart';
import '/domain/interactors/categories_interactor.dart';
import '/domain/interactors/tasks_interactor.dart';

const _allTag = LocaleKeys.all;
const _todayTag = LocaleKeys.today;

class DashboardScreenController extends BaseController {
  DashboardScreenController()
      : _interactor = TasksServices(),
        _cInteractor = CategoriesServices(),
        loader = LoadingController();

  final TasksInteractor _interactor;
  final CategoriesInteractor _cInteractor;
  final LoadingController loader;

  final TextEditingController searchController = TextEditingController();

  List<TaskEntity> _allData = [];
  RxList<TaskEntity> tasks = <TaskEntity>[].obs;

  String? selectedTag;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  bool get _emptyTasksState => tasks.isEmpty;
  Future<void> _loadData() async {
    loader.start();
    await Future.wait([_loadCategories(), _loadTasks()]);
    loader.stop();
  }

  Future<void> _loadCategories() async {
    _cInteractor.fetchCategories();
  }

  Future<void> _loadTasks() async {
    loader.start();
    _allData = await _interactor.allTasks();
    _reloadTasksState();
    loader.stop();
  }

  void refreshTasks() async {
    await _loadTasks();
  }

  void setTaskState(TaskStatus status, TaskEntity task) async {
    if (_emptyTasksState) return;
    final lastStatus = task.status;
    tasks[tasks.indexOf(task)].updateStatus = status;
    await _interactor.updateTask(task);

    if (selectedTag == _allTag || selectedTag == _todayTag) {
      tasks.refresh();
      return;
    }

    onSelectTag(lastStatus.name);

    if (_emptyTasksState) {
      selectedTag = _allTag;
      _reloadTasksState();
    }
  }

  CategoryEntity? onFindCategory(int? id) {
    if (id == null) return null;
    return _cInteractor.findOne(id);
  }

  ///To extract tags from task status
  List<String> get otherTags {
    return _allData.map((e) => e.status.name).toSet().toList();
  }

  ///To update tasks state value
  set _updateTasksState(List<TaskEntity> list) {
    tasks.value = list;
  }

  ///Select un deleted tasks
  void _reloadTasksState() {
    selectedTag = _allTag;
    _updateTasksState = _filterTasks((e) => e.status != TaskStatus.deleted);
  }

  ///To rerun list of task from [_allData] by tester
  List<TaskEntity> _filterTasks(bool Function(TaskEntity) tester) {
    return _allData.where(tester).toList();
  }

  ///To search on tasks list
  void onSearch(String? query) {
    if (_emptyTasksState) return;
    if ((query ?? '').isEmpty) {
      onSelectTag(selectedTag ?? _allTag);
      return;
    }

    _updateTasksState = _listFromTag(selectedTag ?? _allTag)
        .where((e) => '${e.description} ${e.title}'.contains(query!))
        .toList();
  }

  void _extractTodayTask() {
    _updateTasksState = _filterTasks((e) => e.dueDate?.isToday == true);
  }

  void onSelectTag(String tag) {
    selectedTag = tag;

    if (tag == _allTag) {
      _reloadTasksState();
      return;
    }

    if (tag == _todayTag) {
      _extractTodayTask();
      return;
    }

    _updateTasksState = _listFromTag(tag);
  }

  List<TaskEntity> _listFromTag(String tag) {
    return _filterTasks((e) => e.status.name == tag);
  }

  ///To return only deleted tasks list
  List<TaskEntity> get deletedTasks {
    return _filterTasks((p0) => p0.status == TaskStatus.deleted);
  }
}
