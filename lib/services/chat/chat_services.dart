import 'package:chat_app/models/message_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send messages
  Future<void> sendMessage(String recieverId, message) async {
    //get current user info
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;

    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        message: message,
        timestamp: timestamp);
    //construct chat room ID for the two users inserted to ensure uniqueness
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('-');
    //add new message to database
    await firestore
        .collection("Room")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
    //get messages
  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('-');
    return firestore
        .collection('Room')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
