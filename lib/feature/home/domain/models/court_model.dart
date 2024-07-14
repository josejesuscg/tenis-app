class Court {
  final String title;
  final String type;
  final String date;
  final String status;
  final String time;
  final String imageUrl;
  final String precio;
  final String direccion;
  final bool isFavorite;
  

  Court(
      this.title, 
      this.type, 
      this.date, 
      this.status, 
      this.time, 
      this.imageUrl, 
      this.precio, 
      this.direccion,
      {this.isFavorite = false});
}