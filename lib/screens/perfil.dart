import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  DateTime? _aniversari;
  XFile? _imatge;
  final ImagePicker _picker = ImagePicker();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _seleccionaImatge() async {
    final XFile? imatgeSeleccionada = await _picker.pickImage(source: ImageSource.gallery);
    if (imatgeSeleccionada != null) {
      setState(() {
        _imatge = imatgeSeleccionada;
      });
    }
  }

  Future<void> _seleccionaData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _aniversari ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ca', 'ES'),
    );
    if (picked != null && picked != _aniversari) {
      setState(() {
        _aniversari = picked;
      });
    }
  }

  Future<String?> _pujaImatgeAFirebase() async {
    if (_imatge == null) return null;
    File file = File(_imatge!.path);
    try {
      final String nomFitxer = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.png';
      final ref = FirebaseStorage.instance.ref().child(nomFitxer);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDescarga = await snapshot.ref.getDownloadURL();
      return urlDescarga;
    }
    catch (e) {
      print('Error pujant la imatge: $e');
      _showSnackBar('Error pujant la imatge.');
      return null;
    }
  }

  Future<void> _desaDades() async {
    if (!_formKey.currentState!.validate()) return;

    String? urlImatge = await _pujaImatgeAFirebase();

    final dades = {
      'nom': _nomController.text,
      'aniversari': _aniversari != null ? _aniversari!.toIso8601String() : null,
      'imatgeUrl': urlImatge,
      'actualitzat': DateTime.now(),
    };

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        _showSnackBar('Cap usuari loguejat');
        return;
      }

      final String userId = user.uid;

      await FirebaseFirestore.instance
          .collection('usuaris')
          .doc(userId)
          .set(dades, SetOptions(merge: true));

      _showSnackBar('Dades guardades amb èxit!');
    } catch (e) {
      _showSnackBar('Error en desar les dades: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _seleccionaImatge,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imatge != null ? FileImage(File(_imatge!.path)) : null,
                  child: _imatge == null ? const Icon(Icons.person, size: 60) : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Introdueix un nom' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      child: GestureDetector(
                        onTap: () => _seleccionaData(context),
                        child: Text(
                          _aniversari != null
                              ? '${_aniversari!.day}/${_aniversari!.month}/${_aniversari!.year}'
                              : 'Aniversari',
                          style: TextStyle(color: _aniversari != null ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _desaDades,
                child: const Text('Desar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
