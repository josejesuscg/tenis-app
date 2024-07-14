class Reservation {
  int? id;
  String title;
  String date;
  String user;
  String imageUrl;
  String? price;
  String? instructor;
  int? time;

  Reservation({
    this.id,
    required this.title,
    required this.date,
    required this.user,
    required this.imageUrl,
    this.price,
    this.instructor,
    this.time
  });

  factory Reservation.fromMap(Map<String, dynamic> json) => Reservation(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    user: json["user"],
    imageUrl: json["imageUrl"],
    price: json["price"],
    instructor: json["instructor"],
    time: json['time'],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "date": date,
    "user": user,
    "imageUrl": imageUrl,
    "price": price,
    "instructor": instructor,
    "time" : time
  };
}
