import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Pastikan untuk mengimpor Firestore
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pembelian Mobil", style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.streamData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data!.size != 0) {
                    var data = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.deepPurple,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              leading: const Icon(
                                Icons.car_rental,
                                color: Colors.blue,
                              ),
                              onTap: () => Get.toNamed(Routes.UPDATE,
                                  arguments: data[index]
                                      .id), // Navigasi ke halaman UPDATE dengan ID dokumen
                              title: Text(
                                data[index]['nama'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ), // Menampilkan field 'title'
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jenis Mobil: ${data[index]['tipe']}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () => controller.deleteData(
                                    data[index].id),
                                icon: const Icon(
                                    Icons.delete), 
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No Data!",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7B78AA),
        onPressed: () {
          Get.toNamed(Routes.CREATE); // Navigasi ke halaman CREATE
        },
        child: const Icon(Icons.add,
            color: Colors.white), // Ikon untuk FloatingActionButton
      ),
    );
  }
}