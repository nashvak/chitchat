import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverId;
  ChatPage({super.key, required this.recieverEmail, required this.recieverId});
  final TextEditingController messageController = TextEditingController();
  final ChatServices chatServices = ChatServices();
  final AuthService authService = AuthService();
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatServices.sendMessage(recieverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    String senderId = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatServices.getMessages(recieverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Waiting");
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => buildMessageItem(doc))
                  .toList());
        });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data['message']);
  }
}
