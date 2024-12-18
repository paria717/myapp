import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}



class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    supabase.from('messages').stream(primaryKey: ['id']);
    supabase
        .channel('my_channel')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'messages',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'room_id',
              value: 200,
            ),
            callback: (PostgresChangePayload payload) {
              final Map<String, dynamic> newRecord = payload.newRecord;
              final Map<String, dynamic> oldRecord = payload.oldRecord;
            })
        .subscribe();

    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
