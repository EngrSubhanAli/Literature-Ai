import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:http/http.dart' as http;
import 'package:mvvm/view/chatmodel.dart';


class MessageChatScreen extends StatefulWidget {
  const MessageChatScreen({super.key});

  @override
  State<MessageChatScreen> createState() => _MessageChatScreenState();
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  TextEditingController inputController = TextEditingController();
  List<MessageModal> messages = [];
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocus = FocusNode(); // Step 1
  bool isStartChat = false;

  @override
  void initState() {
    super.initState();
    messages = [];
    //  _startChatWithGPT("");
  }

  void _startChatWithGPT(String userInput) async {
    try {
      String response = await chatWithGPT(userInput);

      setState(() {
        messages.add(MessageModal(
          messageContent: userInput,
          messageType: "sender",
        ));
        messages.add(MessageModal(
          messageContent: response,
          messageType: "receiver",
        ));
      });
      _scrollToLatestMessage();
    } catch (error) {
      // Handle the error if the chat with GPT fails

      setState(() {
        messages.add(MessageModal(
          messageContent: 'An error occurred while communicating with GPT1.',
          messageType: "receiver",
        ));
      });
      _scrollToLatestMessage();
    }
  }

  void _sendMessage() {
    String userMessage = inputController.text;

    if (userMessage.isNotEmpty) {
      _textFieldFocus.unfocus();
      setState(() {
        messages.add(MessageModal(
          messageContent: userMessage,
          messageType: "sender",
        ));
      });

      // Send the user's message to GPT
      _continueChatWithGPT(userMessage);
      _scrollToLatestMessage();
      inputController.clear();
    }
  }

  void _scrollToLatestMessage() {
    // Delay scrolling to ensure the new message has been rendered
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _continueChatWithGPT(String input) async {
    try {
      String response = await chatWithGPT(input);
      setState(() {
        messages.add(MessageModal(
          messageContent: response,
          messageType: "receiver",
        ));
      });
      _scrollToLatestMessage();
    } catch (error) {
      // Handle the error if the chat with GPT fails
      print('Error: $error');
      setState(() {
        messages.add(MessageModal(
          messageContent: 'An error occurred while communicating with GPT.',
          messageType: "receiver",
        ));
      });
      _scrollToLatestMessage();
    }
  }

  Future<String> chatWithGPT(String userInput) async {
    setState(() {
      isStartChat = true;
    });
    const apiUrl = 'https://api.openai.com/v1/chat/completions';
    const apiKey = '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';

    final headers = {
      "Content-Type": 'application/json',
      'Authorization': 'Bearer $apiKey',
      
    };

    final data = 
      { 
        'model': 'gpt-3.5-turbo-0125',
        'prompt': inputController.text,

      }
    ;

    debugPrint("hello data: $data");

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    print("responser" + response.body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print("response data: ${responseData.runtimeType}");

      // Assuming the API returns a list of responses, return the first response.
      if (responseData.isNotEmpty) {
        setState(() {
          isStartChat = false;
        });
        return responseData['text'];
      } else {
        return 'No response from ChatGPT.';
      }
    } else {
      setState(() {
        isStartChat = false;
      });
      throw Exception('Failed to communicate with ChatGPT API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(width: 5.w),
              // Image.asset(
              //   chatgptdp,
              //   height: 37.h,
              //   width: 37.w,
              // ),
              SizedBox(width: 10.w),
              // sourcesansporText(text: "CHAT GPT AI")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 20.h),
              Container(
                height: 0.83.sh - 80,
                // color: blackColor,
                child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Column(
                      children: [
                        _buildChatBubble(message),
                        Visibility(
                          visible: index == messages.length - 1 && isStartChat,
                          child: SpinKitWave(
                            size: 20,
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      index.isEven ? Colors.black : Colors.grey,
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              // SizedBox(height: 20,)
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            // height: 60.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    controller: inputController,
                    focusNode: _textFieldFocus,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                      filled: true,
                      fillColor: Color(0xff222325),
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(13.0),
                      suffixIcon: Container(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: InkWell(
                            onTap: _sendMessage,
                            child: const Icon(Icons.message)
                            
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(MessageModal message) {
    final isSender = message.messageType == 'sender';
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.black : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.messageContent,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
