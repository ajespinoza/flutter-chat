import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  TextEditingController _textController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text("Te", style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text("Test 1", style: TextStyle(color: Colors.black54, fontSize: 12),),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),

      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                itemCount: _messages.length,
                reverse: true,
              ),
            ),

            Divider(height: 1,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: _inputChat(),
            ),
          ],
        )
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if(texto.trim().length > 0){
                      _estaEscribiendo = true;
                    }else{
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                    ? CupertinoButton( 
                        child: Text('Enviar'),
                        onPressed: _estaEscribiendo
                                    ? () => _handleSubmit(_textController.text.trim())
                                    : null
                      )
                    : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue.shade400),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _estaEscribiendo
                                    ? () => _handleSubmit(_textController.text.trim())
                                    : null
                        ),
                      ),
                    ),
            ),
          ],
        ),
      )
    );
  }

  _handleSubmit(String texto){
    if(texto.length == 0) return;
    print(texto);
    
    _textController.clear();
    _focusNode.requestFocus();
    
    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

  }

  @override
  void dispose() {
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}