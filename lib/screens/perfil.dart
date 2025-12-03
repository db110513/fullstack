import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _localitatController = TextEditingController();
  final TextEditingController _mblController = TextEditingController();
  final TextEditingController _naixementController = TextEditingController();

  XFile? _imatge;
  String? _urlImatgeExistent;
  bool _carregantDades = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _carregaDadesUsuari();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _carregaDadesUsuari() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() => _carregantDades = false);
        return;
      }

      final doc = await FirebaseFirestore.instance
          .collection('usuaris')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        _nomController.text = data['nom'] ?? '';
        _localitatController.text = data['localitat'] ?? '';
        _mblController.text = data['mobil'] ?? '';
        _naixementController.text = data['dataNaixement'] ?? '';
        _urlImatgeExistent = data['imatgeUrl'];
      }
    }
    catch (e) {
      print('Error carregant dades: $e');
      _showSnackBar('Error carregant dades del perfil.');
    }
    finally {
      setState(() => _carregantDades = false);
    }
  }

  Future<void> _seleccionaImatge() async {
    final XFile? imatgeSeleccionada = await _picker.pickImage(source: ImageSource.gallery);
    if (imatgeSeleccionada != null) {
      setState(() {
        _imatge = imatgeSeleccionada;
      });
    }
  }

  Future<String?> _pujaImatgeAFirebase() async {
    if (_imatge == null) return _urlImatgeExistent;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showSnackBar('Has de fer login primer');
      return null;
    }

    final safeEmail = user.email?.replaceAll(RegExp(r'[.@]'), '_') ?? 'unknown_user';

    File file = File(_imatge!.path);
    try {
      final String nomFitxer = 'profile_images/$safeEmail.png';
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
      'localitat': _localitatController.text,
      'mobil': _mblController.text,
      'dataNaixement': _naixementController.text,
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
        title: const Text('Perfil', style: AppStyles.appBarText),
      ),
      body: _carregantDades
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppStyles.sizedBoxHeight20,
                    GestureDetector(
                      onTap: _seleccionaImatge,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _imatge != null
                            ? FileImage(File(_imatge!.path))
                            : _urlImatgeExistent != null
                                ? NetworkImage(_urlImatgeExistent!)
                                : null,
                        child: _imatge == null && _urlImatgeExistent == null
                            ? const Icon(Icons.person, size: 60, color: Colors.grey)
                            : null,
                      ),
                    ),
                    AppStyles.sizedBoxHeight60,
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _nomController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person, color: Colors.white70),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Introdueix un nom' : null,
                    ),
                    AppStyles.sizedBoxHeight20,
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _localitatController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Localitat',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_city, color: Colors.white70),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Introdueix una localitat' : null,
                    ),
                    AppStyles.sizedBoxHeight20,
                    TextFormField(
                      controller: _mblController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Mòbil',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone, color: Colors.white70),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introdueix el mòbil';
                        }
                        if (value.length != 9) {
                          return 'El mòbil ha de tenir 9 dígits';
                        }
                        return null;
                      },
                    ),
                    AppStyles.sizedBoxHeight20,
                    TextFormField(
                      controller: _naixementController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Data de naixement (DD/MM/AA)',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake, color: Colors.white70),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderSide:
                        BorderSide(color: Colors.white, width: 2)),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Introdueix la data de naixement' : null,
                    ),
                    AppStyles.sizedBoxHeight40,
                    ElevatedButton(
                      onPressed: _desaDades,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 44),
                        maximumSize: const Size(200, 44),
                      ),
                      child: const Text('Desar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _localitatController.dispose();
    _mblController.dispose();
    _naixementController.dispose();
    super.dispose();
  }
}
