import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Mahasiswa {
  String id, nama, jurusan;
  int usia;

  Mahasiswa({this.nama, this.jurusan, this.usia});

  // Fungsi untuk mengubah dokumen dari firestore kedalam class Mahasiswa
  Mahasiswa.fromDocument(DocumentSnapshot doc){
    id = doc.documentID;
    nama = doc['nama'];
    jurusan = doc['jurusan'];
    usia = doc['usia'];
  }

  //Fungsi ini untuk menambahkan data ke firestore
  Future<DocumentReference> save(){
    var data = {
      'nama': nama, 
      'jurusan': jurusan, 
      'usia': usia 
    };
    
    if(id == null){
      Firestore.instance.collection('mahasiswa').add(data);
    }

    //jika id tersebut ndak kosong, jadi kite hanya update saja
    return Firestore.instance.
           collection('mahasiswa').
           document(id).
           updateData(data);
  }

  Future<void> delete(){
    return Firestore.instance.collection('mahasiswa').document(id).delete();
  }

  //Fungsi ini untuk membaca semua collection yang ada di mahasiswa
  static Stream<QuerySnapshot> getData(){
    return Firestore.instance.collection('mahasiswa').snapshots();
  }
}