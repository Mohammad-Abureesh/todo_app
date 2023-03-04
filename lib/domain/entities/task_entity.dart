import '/core/constants/data_base_config.dart';
import '/core/enums/e_task_status.dart';
import 'base_entity.dart';

class TaskEntity implements BaseEntity {
  final int _id;
  int? _categoryId;
  int _status;
  String _title;
  String? _description;
  final DateTime _creationDate;
  DateTime? _dueDate;

  TaskEntity._(this._id, this._categoryId, this._title, this._description,
      this._creationDate, this._dueDate, this._status);

  TaskEntity.createTask(
      {required String title,
      String? description,
      int? categoryId,
      DateTime? dueDate})
      : _id = 0,
        _categoryId = categoryId,
        _description = description,
        _title = title,
        _status = TaskStatus.unComplete.index,
        _dueDate = dueDate,
        _creationDate = DateTime.now();

  //getters & setters
  @override
  int get id => _id;
  int? get category => _categoryId;

  @override
  String get table => DbConfig.taskT;
  String get title => _title;
  String get description => _description ?? '';

  TaskStatus get status =>
      TaskStatus.values.singleWhere((e) => e.index == _status);

  bool get isComplete => status == TaskStatus.complete;
  bool get isDeleted => status == TaskStatus.deleted;
  bool get hasCategory => _categoryId != null;
  bool get hasDescription => description.isNotEmpty;
  bool get hasDueDate => _dueDate != null;
  bool get isEndTask {
    if (!hasDueDate) return false;
    return DateTime.now().isAfter(_dueDate!);
  }

  DateTime get creationDate => _creationDate;
  DateTime? get dueDate => _dueDate;

  set setCategory(int? id) {
    _categoryId = id;
  }

  set description(String value) {
    _description = value;
  }

  set setTitle(String value) {
    _title = value;
  }

  set setDueDate(DateTime? date) {
    _dueDate = date;
  }

  set updateStatus(TaskStatus status) {
    _status = status.index;
  }

  @override
  Map<String, dynamic> get toMap => {
        'categoryId': _categoryId,
        'title': _title,
        'status': _status,
        'description': _description,
        'createdAt': _creationDate.toIso8601String(),
        'dueDate': _dueDate?.toIso8601String()
      };

  //Factory constructor return task obj from map
  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity._(
        map['id'],
        map['categoryId'],
        map['title'],
        map['description'],
        DateTime.parse(map['createdAt']),
        DateTime.tryParse(map['dueDate'] ?? ''),
        map['status']);
  }

  @override
  String toString() {
    return '''
   Task Details
     
     Title : $title
     Description : $description
     Status : ${status.name}
     ${'-' * 30}
     Due date at ${dueDate?.toIso8601String() ?? 'UNKNOWN'}
     Created at ${creationDate.toIso8601String()}
     ${'-' * 30}
    ''';
  }
}
