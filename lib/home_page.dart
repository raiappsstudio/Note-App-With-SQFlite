import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note App")),

      body:
          allNotes.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: allNotes.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Text(
                        "${allNotes[index][DBHelper.COLUMN_NOTE_SNO]}",
                      ),
                      title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                      subtitle: Text(
                        allNotes[index][DBHelper.COLUMN_NOTE_DESC],
                      ),
                      trailing: SizedBox(
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /* IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                          SizedBox(width: 5),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete)),*/
                            InkWell(
                              onTap: () {
                                _titleController.text =
                                    allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                                _descController.text =
                                    allNotes[index][DBHelper.COLUMN_NOTE_DESC];
                                _buildBottomSheet(context, isUpdate: true, sno:allNotes[index][DBHelper.COLUMN_NOTE_SNO] );
                              },
                              child: Icon(Icons.edit),
                            ),

                            InkWell(
                              onTap: () {
                                dbRef!.deleteNote(sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                                getNotes();

                              },
                              child: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
              : Center(child: Text('No Notes yet')),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _titleController.clear();
          _descController.clear();

          /* bool check = await dbRef!.addNote(
            mTitle: "this is new Notes",
            mDesc: "if you do the hard work then you can success any work",
          );
          if (check) {
            getNotes();
          }*/

          _buildBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _buildBottomSheet(
    BuildContext context, {
    bool isUpdate = false,
    int sno = 0,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  isUpdate ? 'Update Note' : "Add Note",
                  style: TextStyle(fontSize: 24),
                ),

                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
                    label: Text('Title'),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),

                const SizedBox(height: 11),
                TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Description Here",
                    label: Text('Desc'),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),

                        onPressed: () {
                          var title = _titleController.text;
                          var desc = _descController.text;

                          if (title.isNotEmpty && desc.isNotEmpty) {
                            isUpdate
                                ? dbRef!.updateNote(
                                  title: title,
                                  desc: desc,
                                  sno: sno,
                                )
                                : dbRef!.addNote(mTitle: title, mDesc: desc);
                            getNotes();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'add not add please fill up all fild',
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text(isUpdate ? 'Update Now' : "Add Now"),
                      ),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),

                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
