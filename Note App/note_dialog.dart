import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDialog extends StatefulWidget {
  final int? noteid;
  final String? title;
  final String? content; // you can keep this name if you want
  final int colorindex;
  final List<Color> noteColors;
  final Function onNoteSaved;

  const NoteDialog({
    super.key,
    this.noteid,
    this.title,
    this.content,
    required this.colorindex,
    required this.noteColors,
    required this.onNoteSaved, String? description,
  });

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late int selectedcolorindex;
  late TextEditingController titlecontroller;
  late TextEditingController descriptioncontroller;

  @override
  void initState() {
    super.initState();
    selectedcolorindex = widget.colorindex;

  }

  @override
  Widget build(BuildContext context) {

    final titleController=TextEditingController(
      text: widget.title,
    );
    final descriptioncontroller=TextEditingController(
text: widget.content,
    );
    final currentDate = DateFormat('E dd MMM').format(DateTime.now());
  

    return AlertDialog(
      backgroundColor: widget.noteColors[selectedcolorindex],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        widget.noteid == null ? 'Add note' : 'Edit Note',
        style: const TextStyle(
          color: Colors.black87,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentDate,
            style:TextStyle(
              color: Colors.black54,
              fontSize: 24,
            ) ,),
            const SizedBox(height: 10),

            TextField(
              controller: titleController,
              decoration:  InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'title',
                border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(12),
borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descriptioncontroller,
              maxLines: 5,
              decoration: InputDecoration(
                 filled: true,
                fillColor: Colors.white,
                labelText: 'description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(12),
borderSide: BorderSide.none,

                ),
              ),
                
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: List.generate(
                widget.noteColors.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedcolorindex = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: widget.noteColors[index],
                    child: selectedcolorindex == index
                        ? const Icon(Icons.check, color:Colors.black54,size:16)
                        : null,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel',style: TextStyle(
            color: Colors.black54,
          )),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
backgroundColor: Colors.black87,
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
)
          ),
          onPressed: () async{
            final newtitle=titleController.text;
final newdescription=descriptioncontroller.text;
widget.onNoteSaved(newtitle,newdescription,currentDate,selectedcolorindex);
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}