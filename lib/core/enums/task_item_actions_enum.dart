enum TaskItemActionsEnum {
  edit(name: 'Edit'),
  delete(name: 'Delete');

  final String name;
  const TaskItemActionsEnum({required this.name});
}