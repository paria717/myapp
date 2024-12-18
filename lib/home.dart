import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
  final supabase = Supabase.instance.client;
class _HomeState extends State<Home> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(20),
                child: StreamBuilder(
                  stream: supabase.from('notes').stream(primaryKey: ['id']),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Text(snapshot.data![index]['body']);
                      },
                    );
                  },
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            // height: 30, width: 40,
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(80), color: Colors.blue[50]),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: controller,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await supabase.from('notes').insert({'body': controller.text}).then(
                        (value) {
                          controller.clear();
                        },
                      );
                    },
                    icon: const Icon(Icons.send)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
