class TaskModel {
  final int id;//
  final String taskName;

  final String taskDescription;

  final bool taskHighPriority;
  bool isDone;//
  String ? motivationQuote;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.taskHighPriority,//
    this.isDone = false,//
    this.motivationQuote
  });

  /// الداتا اللي في الشرد برفرنس
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      //بملاء عن طريق الاسماء اللي جايه من الشارد برفرنس اللي في الاد تاسك
      id: json["id"],
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      taskHighPriority: json["taskHighPriority"],
      isDone: json["isDone"] ?? false,
      /// isDone: json["isDone"] == null ? false : json["isDone"],
      ///في داتا قبل كدا في الشرد برفرنس مش فيها اذ ضن دي بقا يا باشا عملنالها السطر ده
      motivationQuote: json['motivationGuote']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "taskHighPriority": taskHighPriority,
      "isDone": isDone,
      "motivationGuote":motivationQuote,
    };
  }
}
