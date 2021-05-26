class NotificationModel {
  int id;
  String name;
  String body;
  String image;

  NotificationModel({
    this.id,
    this.name,
    this.body,
    this.image,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return new NotificationModel(
      id: map['_id'] as int,
      name: map['name'] as String,
      body: map['body'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'body': this.body,
      'image': this.image,
    };
  }
}
