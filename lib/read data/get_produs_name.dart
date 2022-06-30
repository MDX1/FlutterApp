import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetProdusName extends StatelessWidget {
  final String documentId;

  GetProdusName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference produs =
        FirebaseFirestore.instance.collection('produse');

    return FutureBuilder<DocumentSnapshot>(
      future: produs.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //vsplivaiushee okno
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Denumirea: " +
                              '${data['Denumire produs']}' +
                              "\nCantitatea: " +
                              '${data['Cantitate produs']}' +
                              "\nPret: " +
                              '${data['Pret produs']}' +
                              "\nPozitia: " +
                              '${data['Pozitie produs']}',
                          style: TextStyle(fontSize: 35),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                              child: Text('Inchide')),
                        ],
                      );
                    });
              },
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Denumire:' + ' ${data['Denumire produs']}',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Cantitate: ' + '${data['Cantitate produs']}',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Pozitie: ' + '${data['Pozitie produs']}',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_sweep, color: Colors.red),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Doriti sa stergeti?',
                                style:
                                    TextStyle(fontFamily: 'Times New Roman')),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Nu',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Times New Roman")),
                              ),
                              TextButton(
                                onPressed: () => [
                                  Navigator.pop(context, 'Cancel'),
                                  print('')
                                ],
                                //FirebaseFirestore.instance.collection('produse').doc(produs[documentId]).delete()],
                                child: const Text('Da',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Times New Roman")),
                              ),
                            ],
                          ));
                },
              ),
            ),
          ); //Text('Denumire Produs: ${data['Denumire produs']}');
        }
        return Text('Loading..');
      }),
    );
  }
}
