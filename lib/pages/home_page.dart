import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/scan.dart';
import 'package:flutter_project/read%20data/get_produs_name.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  late Future _future;

  // document ID's
  List<String> docIDs = [];
  // get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('produse')
        .orderBy('Denumire produs', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              //snapshot si document punem noi denumirea
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  //text fields controllerN
  final _itemController = TextEditingController();
  final _cantitateController = TextEditingController();
  final _pretController = TextEditingController();
  final _pozitieController = TextEditingController();

  @override
  void dispose() {
    _itemController.dispose();
    _cantitateController.dispose();
    _pretController.dispose();
    _pozitieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      _future = getDocId();
      super.initState();
    });
  }

  Future addProdus() async {
    setState(() {
      addItems(
        _itemController.text.trim(),
        int.parse(_cantitateController.text.trim()),
        double.parse(_pretController.text.trim()),
        _pozitieController.text.trim(),
      );
    });
  }

  Future addItems(String denumireProdus, int cantitateProdus, double pretProdus,
      String pozitieProdus) async {
    await FirebaseFirestore.instance.collection('produse').add({
      'Denumire produs': denumireProdus,
      'Cantitate produs': cantitateProdus,
      'Pret produs': pretProdus,
      'Pozitie produs': pozitieProdus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Qscanner()));
          }, icon: Icon(Icons.qr_code))
        ],
        backgroundColor: Colors.deepPurple[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
        title: Text(
          'Produse',
          style: TextStyle(
            fontFamily: 'Times new Roman',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('signed as: ' + user.email!),
            Expanded(
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: GetProdusName(documentId: docIDs[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple[300],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[300],
                title: Text(
                  'Adaugare produs',
                  style: GoogleFonts.bebasNeue(fontSize: 30),
                ),
                content: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ADD ITEM - DENUMIREA
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _itemController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Denumire produs',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),

                        //Adaugare
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _cantitateController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Cantitatea produsului',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _pretController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Pretul produsului',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _pozitieController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Pozitia in depozit',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        //buton
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Adauga',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                color: Colors.deepPurple[300],
                                textColor: Colors.white,
                                onPressed: () =>
                                    [Navigator.pop(context), addProdus()]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// body: Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text('signed as: ' + user.email!,style: TextStyle(fontSize: 20)),
//       MaterialButton(onPressed: (){
//         FirebaseAuth.instance.signOut();
//       },
//       color: Colors.blue,
//       child: Text('Iesire din profil')
//       )
//     ],
//   )
// )
