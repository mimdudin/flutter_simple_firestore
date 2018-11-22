import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_firestore/Models/mahasiswa.dart';
import 'package:learn_firestore/form_mahasiswa.dart';

class ListMahasiswa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: StreamBuilder(
        stream: Mahasiswa.getData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var items = snapshot.data.documents.map((doc) {
              var mahasiswa = Mahasiswa.fromDocument(doc);

              return ListTile(
                title: Text(mahasiswa.nama),
                subtitle: Text(mahasiswa.jurusan),
                trailing: Text('${mahasiswa.usia} tahun'),
                onTap: () => gotoForm(context, mahasiswa),
              );
            }).toList();

            if (items.length == 0) {
              return Center(
                child: Text('Data mahasiswa masih kosong'),
              );
            }
            return ListView.builder(
               itemBuilder: (_, index) => items[index],
               itemCount: items.length,
              );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => gotoForm(context, null),
        )
    );
  }

  void gotoForm(BuildContext context, Mahasiswa mahasiswa){
    var route = MaterialPageRoute(builder: (BuildContext context) {
             return FormMahasiswa(mahasiswa);
           });
           
           Navigator.push(context, route); 
  }
}
