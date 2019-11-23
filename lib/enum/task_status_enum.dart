enum TaskStatus{
  todo,
  doing,
  pending_done,
  done,
}

String getTaskStatusStringEnum(TaskStatus status){
  Map<TaskStatus,String> string = {
    TaskStatus.todo:"Todo",
    TaskStatus.doing:"Doing",
    TaskStatus.pending_done:"Pending",
    TaskStatus.done:"Done"
  };

  return string[status];
}