import 'package:flutter/material.dart';

class ParkingDetailsPage extends StatelessWidget {
  const ParkingDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Background
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('map.png'), // Gambar peta
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 40,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        // Parking Details
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Abah Bas Parkir',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '> 30m',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Action untuk tombol close
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                // Vehicle Details
                Row(
                  children: [
                    Image.asset(
                      'agya.png', // Gambar kendaraan
                      height: 80,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Details vehicle',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Number Police'),
                              Text('Color'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'BA1993CZ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Red Metallic',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Pricing Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'IDR 7.000/Hour',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Book Now Button
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Aksi saat tombol ditekan
                    },
                    child: const Text(
                      'Book Now',
                      style: TextStyle(fontSize: 16),
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}