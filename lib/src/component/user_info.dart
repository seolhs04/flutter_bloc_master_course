import 'package:flutter/material.dart';
import 'package:flutter_bloc_master_course/src/model/user_info_result.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key, required this.userInfo});

  final UserInfo userInfo;

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: Image.network(widget.userInfo.profileImage).image,
      ),
      title: Text(
        widget.userInfo.email,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userInfo.name,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.phone, size: 14),
              Text(
                widget.userInfo.phone,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          )
        ],
      ),
    );
  }
}
