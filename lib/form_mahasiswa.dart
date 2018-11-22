import 'package:flutter/material.dart';
import 'package:learn_firestore/Models/mahasiswa.dart';
import 'package:learn_firestore/list_mahasiswa.dart';

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa mahasiswa;

  FormMahasiswa([this.mahasiswa]);

  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  Mahasiswa mahasiswa;

  @override
    void initState() {
      super.initState();

      mahasiswa = widget.mahasiswa ?? Mahasiswa(nama: '', jurusan: '', usia: 17);

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Tambah Mahasiswa'),
        actions: <Widget>[
         IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            onPressed: () => saveForm(context)
            )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: ListView(
          children: <Widget>[
            TextFormField(
              initialValue: mahasiswa.nama,
              validator: (v) => v.length < 5 ? 'Harus lebih dari 5 karakter' 
              : null,
              onSaved: (v) => mahasiswa.nama = v,
              decoration:
                  InputDecoration(
                    labelText: 'Nama', 
                    icon: Icon(Icons.person)),
            ),
            TextFormField(
              validator: (v) => v.length < 5 ? 'Jurusan lebih dari 5 karakter' 
              : null,
              initialValue: mahasiswa.jurusan,
              onSaved: (v) => mahasiswa.jurusan = v,
              decoration:
                  InputDecoration(
                    labelText: 'Jurusan', 
                    icon: Icon(Icons.category)),
            ),
            TextFormField(
              validator: (v) => v.length < 2 ? 'Usia lebih dari 2 karakter' 
              : null,
              initialValue: mahasiswa.usia.toString(),
              onSaved: (v) => mahasiswa.usia = int.parse(v),
              decoration:
                  InputDecoration(
                    labelText: 'Usia', 
                    icon: Icon(Icons.cake)),
            )
          ],
        ),
      ),),
    );
  }

  void saveForm(BuildContext c){
    if(!_formKey.currentState.validate()){
      return;
    }

    _formKey.currentState.save();
    mahasiswa.save().then((ref){
      var newRoute = MaterialPageRoute(builder: (BuildContext context) {
       return ListMahasiswa(); 
      });
      // var snackbar = new SnackBar(content: Text('Data Berhasil di Simpan'));
      mahasiswa.id = ref.documentID;
      Navigator.pushReplacement(context, newRoute);
      // _scaffold.currentState.showSnackBar(snackbar);
    }); 
  }
}
