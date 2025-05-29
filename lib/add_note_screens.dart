import 'package:flutter/material.dart';
import 'package:noteappwithsqflige/db_helper.dart';
import 'package:noteappwithsqflige/db_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreens extends StatelessWidget {
  bool isUpdate;
  String title;
  String desc;
  int sno;
  //DBHelper? dbRef = DBHelper.getInstance;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  AddNoteScreens({
    this.isUpdate = false,
    this.sno = 0,
    this.title = "",
    this.desc = "",
  });

  @override
  Widget build(BuildContext context) {

    if(isUpdate){
      _titleController.text =title;
      _descController.text = desc;
    }


    return Scaffold(
      appBar: AppBar(title: Text(isUpdate ? 'Update Note' : "Add Note",
        style: TextStyle(fontSize: 24)),
      centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

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

                    onPressed: () async {
                      var title = _titleController.text;
                      var desc = _descController.text;

                      if (title.isNotEmpty && desc.isNotEmpty) {
                      /*  bool check = isUpdate;

                        if (check) {
                          await dbRef!.updateNote(
                            title: title,
                            desc: desc,
                            sno: sno,
                          );
                        } else {
                          dbRef!.addNote(mTitle: title, mDesc: desc);
                          Navigator.pop(context);

                        }

                        if (check) {
                          Navigator.pop(context);
                        }*/

                        if(isUpdate){
                          context.read<DBProvider>().updateNote(title, desc, sno);
                        }else{
                          context.read<DBProvider>().addNote(title, desc);
                        }

                        Navigator.pop(context);



                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in all fields')),
                        );
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
  }
}
