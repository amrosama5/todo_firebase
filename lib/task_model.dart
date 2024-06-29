class TaskModel {
  static const String collectionName="Tasks";
  late String id;
  late String title;
  late String description;
  late int date;
  late bool isDone;
  late String dateTime;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
        required this.dateTime,
      this.isDone = false, required this.userId
      });

  TaskModel.fromJson(Map<String,dynamic> json):this(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: json['date'],
    isDone: json['isDone'],
      dateTime: json['dateTime'],
    userId: json['userId']
  );



  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'description':description,
      'date':date,
      'isDone':isDone,
      'dateTime':dateTime,
      'userId':userId
    };
  }
}
