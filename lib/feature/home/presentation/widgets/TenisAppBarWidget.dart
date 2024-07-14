import 'package:flutter/material.dart';


class TenisAppBar extends StatelessWidget  implements PreferredSizeWidget {

  GlobalKey<ScaffoldState> scaffoldKey;
  
  TenisAppBar({
    super.key,
    required this.scaffoldKey
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Text(
            'Tennis',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            ' court',
            style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        CircleAvatar(
          backgroundImage:
              AssetImage('assets/images/user.jpg'), // Imagen del usuario
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            // Acción para notificaciones
          },
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            scaffoldKey.currentState?.openEndDrawer();
          },
        ),
        SizedBox(width: 16),
      ],
      
    );
  }
  
   @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
