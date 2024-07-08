import 'package:chatapp/components/chatbubble.dart';
import 'package:chatapp/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/messages.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  ChatPage({this.email, super.key});
  String? email;
  static String id = 'chatpage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();

  final scollcontroller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  @override
  Widget build(BuildContext context) {
    String? email = ModalRoute.of(context)!.settings.arguments as String?;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: ((context, snapshot) {
        print('time ============== ${DateTime.now().toString()}');
        String? data;
        if (snapshot.hasData) {
          List<Messages> listOfMessages = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            listOfMessages.add(Messages.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 55,
                  ),
                  const Text('Chat')
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scollcontroller,
                    itemCount: listOfMessages.length,
                    itemBuilder: (context, index) {
                      return listOfMessages[index].id == email
                          ? ChatBubble(message: listOfMessages[index])
                          : ChatBubbleV2(message: listOfMessages[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (String? value) {
                      data = value!;
                    },
                    controller: controller,
                    onSubmitted: (data) {
                      print('=== data ===: ${snapshot.data}');
                      messages.add({
                        'message': data,
                        'createdAt': DateTime.now().toString(),
                        'id': email
                      });
                      controller.clear();
                      scollcontroller.animateTo(0,
                          duration: const Duration(seconds: 200),
                          curve: Curves.easeIn);
                      ;
                    },
                    decoration: InputDecoration(
                        hintText: 'Message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            addMessage(data, email);
                          },
                          icon: const Icon(Icons.send),
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22))),
                  ),
                )
              ],
            ),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
                child: Text(
              'Loading...',
              style: TextStyle(fontSize: 32),
            )),
          );
        } else {
          return const Scaffold(
            body: Center(
                child: Text(
              'Loading...',
              style: TextStyle(fontSize: 32),
            )),
          );
        }
      }),
    );
  }

  void addMessage(String? data, String? email) {
    messages.add(
        {'message': data, 'createdAt': DateTime.now().toString(), 'id': email});
    controller.clear();
    scollcontroller.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }
}
