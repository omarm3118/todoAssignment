class TaskModel {
  int? id;
  String? title;
  String? note;
  bool? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    note = json['note'].toString();
    isCompleted = json['isCompleted'] == 0 ? false : true;
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title.toString(),
      'note': note.toString(),
      'isCompleted': isCompleted ?? false ? 1 : 0,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }
}
