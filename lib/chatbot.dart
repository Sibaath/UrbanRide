import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final String _url = "https://web-production-11ed.up.railway.app/api/api1/";

  // final String _url =
  // "https://web-production-6891.up.railway.app/api/OnelifeChatbot/";

  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty || _isLoading) return;

    final userInput = _controller.text;
    setState(() {
      _messages.add(Message(text: userInput, isUser: true));
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': userInput}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseText = data['response_text'];

        setState(() {
          _messages.add(Message(text: responseText, isUser: false));
          _isLoading = false;
        });
      } else {
        _handleError("Error: ${response.statusCode}");
      }
    } catch (error) {
      _handleError("Error: ${error.toString()}");
    }
    _scrollToBottom();
  }

  void _handleError(String errorMessage) {
    setState(() {
      _messages.add(Message(text: errorMessage, isUser: false));
      _isLoading = false;
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onSubmitted: (_) => _sendMessage(),
              enabled: !_isLoading,
            ),
          ),
          SizedBox(width: 8),
          _isLoading
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) SizedBox(width: 40),
          if (message.isUser) _buildAvatar(isUser: true),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                  left: message.isUser ? 8 : 0, right: message.isUser ? 0 : 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.blue[800] : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (!message.isUser) _buildAvatar(isUser: false),
          if (message.isUser) SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildAvatar({required bool isUser}) {
    return CircleAvatar(
      backgroundColor: isUser ? Colors.blue[700] : Colors.grey[700],
      child: Icon(
        isUser ? Icons.person : Icons.android,
        color: Colors.white,
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
