class TaskModel {
  final String taskName;
  final int taskID;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.taskName,
    required this.taskID,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'],
      taskID: json['taskID'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskID': taskID,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }
}
