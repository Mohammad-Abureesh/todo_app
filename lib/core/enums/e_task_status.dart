enum TaskStatus {
  ///Normal state when complete the task
  complete,

  ///Initial state for an new task
  unComplete,

  ///End state for an task has due date & the due date is before [DateTime.now]
  endWithoutComplete,

  ///Deleted task state
  ///an task with deleted status can find only inside the recycle pin
  deleted
}
