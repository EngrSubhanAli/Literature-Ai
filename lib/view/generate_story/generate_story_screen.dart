import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mvvm/Core/Components/helper_components.dart';
import 'package:mvvm/Core/Components/text_widget.dart';
import 'package:mvvm/Core/constant/assets.dart';
import 'package:mvvm/Core/constant/colors.dart';

// class GenerateStoryScreen extends StatefulWidget {
//   const GenerateStoryScreen({super.key});

//   @override
//   State<GenerateStoryScreen> createState() => _GenerateStoryScreenState();
// }

// class _GenerateStoryScreenState extends State<GenerateStoryScreen> {
//   TextEditingController generateStory = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SizedBox(
//         height: 1.sh,
//         child: Column(
//           children: [
//             VerticalSizedBox(vertical: 40.h),
//             Row(
//               children: [
//                 HorizontalSizedBox(horizontalSpace: 20.w),
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: const Icon(
//                     Icons.arrow_back_ios,
//                   ),
//                 ),
//                 HorizontalSizedBox(horizontalSpace: 20.w),
//                 CustomText(
//                   text: "LITERATURE.AI",
//                   fontSize: 16.sp,
//                   color: blackColor,
//                   fontWeight: FontWeight.w400,
//                 )
//               ],
//             ),
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: CustomText(
//                 textAlign: TextAlign.center,
//                 text: "Get Help From LITERATURE.AI About Your Story",
//                 fontSize: 16.sp,
//                 color: greyColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: whiteColor,
//                   border: Border.all(color: const Color(0xff8E8870)),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 10, top: 3, bottom: 3, right: 3),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(maxHeight: 6 * 20.0),
//                       child: TextField(
//                         maxLines: null, // Allow unlimited lines initially
//                         keyboardType: TextInputType.multiline,
//                         controller: generateStory,
//                         onChanged: (text) {
//                           // Limiting the text field to 4 lines
//                           if (generateStory.text.split('\n').length > 4) {
//                             setState(() {
//                               // Remove excess lines beyond 4
//                               generateStory.text = generateStory.text
//                                   .split('\n')
//                                   .take(4)
//                                   .join('\n');
//                             });
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintStyle: const TextStyle(color: blackColor),
//                           suffixIconColor: blackColor,
//                           prefixIconColor: blackColor,
//                           suffixIcon: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(
//                               send,
//                               height: 15.h,
//                               width: 15.w,
//                             ),
//                           ),
//                           border: InputBorder.none,
//                         ),
//                         // obscureText: widget.obscureText,
//                         // keyboardType: widget.keyboardType,
//                         // onChanged: widget.onChanged,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             VerticalSizedBox(vertical: 20.h),
//           ],
//         ),
//       ),
//     ));
//   }
// }

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class GenerateStoryScreen extends StatefulWidget {
  String? preresponse;
  GenerateStoryScreen({super.key,  this.preresponse});

  @override
  State<GenerateStoryScreen> createState() => _GenerateStoryScreenState();
}

class _GenerateStoryScreenState extends State<GenerateStoryScreen> {
  final _openAI = OpenAI.instance.build(
    token: "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",
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 20,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Arbab', lastName: 'Shujaat');

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'LITERATURE.', lastName: 'AI');
  TextEditingController userMessage = TextEditingController();
  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];


  @override
  void initState() {
    if (widget.preresponse != "") {
        ChatMessage message = ChatMessage(
      user: ChatUser(
        id: '1',
      ),
      createdAt: DateTime.now(),
      text:widget.preresponse!);
      getChatResponse(message).then((value) {
        setState(() {});
      });
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: CustomText(
            text: "LITERATURE.AI",
            fontSize: 16.sp,
            color: blackColor,
            fontWeight: FontWeight.w400,
          )),
      body: Stack(
        children: [
          DashChat(
              currentUser: _currentUser,
              typingUsers: _typingUsers,
              inputOptions: InputOptions(
                textController: userMessage,
                alwaysShowSend: true,
                inputDecoration: const InputDecoration(

                    // suffixIcon: userMessage.text!=""?const SizedBox(): const Icon(Icons.send_outlined,color: Colors.grey,),
                    border: OutlineInputBorder(
                        gapPadding: 2,
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
              messageOptions:  MessageOptions(
                onPressMessage: (m) async {
                  await Clipboard.setData( ClipboardData(text: m.text));
                    Fluttertoast.showToast(
            msg: "Response copied to clipboard",
            // toastLength: Toast
            //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            timeInSecForIosWeb: 1, // Time duration for iOS and web
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );

                },
                onLongPressMessage: (m) async {
                  await Clipboard.setData( ClipboardData(text: m.text));
                    Fluttertoast.showToast(
            msg: "Response copied to clipboard",
            // toastLength: Toast
            //     .LENGTH_SHORT, // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            timeInSecForIosWeb: 1, // Time duration for iOS and web
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );

                },
                showCurrentUserAvatar: false,
                showOtherUsersAvatar: false,
                currentUserContainerColor: Color(0xFFF3ECFF),
                currentUserTextColor: Colors.black,
                containerColor: Color(0xFFEEF2FF),
                textColor: Colors.black,
              ),
              onSend: (ChatMessage m) {
                getChatResponse(m);
              },
              messages: _messages),
          if (_messages.isEmpty)
            Center(
              child: CustomText(
                textAlign: TextAlign.center,
                text: "Get Help From LITERATURE.AI \nAbout Your Story",
                fontSize: 16.sp,
                color: greyColor,
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messagesHistory,
      maxToken: 200,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content),
          );
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}
