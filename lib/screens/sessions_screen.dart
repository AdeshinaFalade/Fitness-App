import 'package:flutter/material.dart';
import 'package:flutter_practice/data/sp_helper.dart';
import '../data/session.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  List<Session> sessions = [];
  final SPHelper helper = SPHelper();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    helper.init().then((value){
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Your Training Sessions')
      ),
      body: ListView(
        children: getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSessionDialog(context);
          },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return  AlertDialog(
              title: const Text('Insert Training Session'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: txtDescription,
                      decoration: const InputDecoration(hintText: 'Description'),
                    ),
                    TextField(
                      controller: txtDuration,
                      decoration: const InputDecoration(hintText: 'Duration'),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      txtDuration.text = '';
                      txtDescription.text = '';
                    },
                    child: const Text('Cancel')
                ),
                ElevatedButton(
                    onPressed: saveSession,
                    child: const Text('Save')
                )
              ],
            );
          });
    }

  Future saveSession() async {
      DateTime now = DateTime.now();
      String today = '${now.year}-${now.month}-${now.day}';
      int id = helper.getCounter() + 1;
      Session newSession = Session(id, today,
      txtDescription.text, int.tryParse(txtDuration.text) ?? 0);
      helper.writeSession(newSession).then((_){
        updateScreen();
        helper.setCounter();
      });
      txtDescription.text = '';
      txtDuration.text = '';
      Navigator.pop(context);
    }

  List<Widget> getContent(){
    List<Widget> tiles = [];
    for ( var session in sessions){
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_){
          helper.deleteSession(session.id).then((value) =>
              updateScreen());
        },
        child: ListTile(
          title: Text(session.description),
          subtitle: Text('${session.date} - duration: ${session.duration} min'),
        ),
      ));
    }
    return tiles;
  }

  void updateScreen() {
    sessions = helper.getSessions();
    setState(() {

    });
  }

}

