import 'package:flutter/material.dart';
import 'package:notes_app/database/notes_database.dart';
import 'package:notes_app/screens/note_card.dart';
import 'package:notes_app/screens/note_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String,dynamic>> notes=[];
   @override
  void initState() {
    super.initState();
    fetchNote();
  }
Future<void> fetchNote() async {
    final fetchedNotes = await NotesDatabase.instance.getNote();
    setState(() {
      notes = fetchedNotes;
    });
  }

  final List<Color> noteColors=[
const Color(0xFF42A5F5),
    const Color(0xFFEF5350),
    const Color(0xFF66BB6A),
    const Color(0xFFFFCA28),
    const Color(0xFFAB47BC),
    const Color(0xFF26C6DA),
    const Color(0xFFFFA726),
    const Color(0xFF78909C),
    const Color(0xFF000000),
    const Color(0xFFFFFFFF),
  ];
  
  void showNoteDialog({
    int? id,String? title,String? content, int colorindex=0}){
showDialog(context: context, 
builder:(dialogContext){
  
  return NoteDialog(colorindex: colorindex,
  noteColors:noteColors,
  noteid: id,
  title: title,
  content: content,
    onNoteSaved:(newtitle,newdescription,currentdate,selectedcolorindex    
    ) async {

if(id==null){
  await NotesDatabase.instance.addNote(
                newtitle,
                newdescription,
                currentdate,
                selectedcolorindex,
              );
}else{
  await NotesDatabase.instance.updateNote(
                newtitle,
                 newdescription,
                currentdate,
                selectedcolorindex,
                  id);
  }
  fetchNote();
    },

  );
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Notes",style: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
showNoteDialog();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add,color: Colors.black87,),
      ),
      body: notes.isEmpty?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notes_outlined,
              size: 20,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 20,),
            Text('No Notes Found',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
            ),
            )
          ],
        ),
      )
      :Padding(
        padding:const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
            ),
            itemCount: notes.length,
         itemBuilder: (context,index){
          final note=notes[index];
          return NoteCard(
            note: note, 
            onDelete: ()async{
await NotesDatabase.instance.deleteNote(note['id']);
fetchNote();
            },
            onTap: () async{
showNoteDialog(
  id: note['id'],
  title: note['title'],
  content: note['description'],
  colorindex: note['color']);
},
    noteColors: noteColors
            );
         }),
         ),
    );
  }
}