import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom Widget 1: ProfileAvatar
            ProfileAvatar(imageUrl: ''),
            SizedBox(height: 16),
            // Custom Widget 2: ProfileInfo (Passing parameter name & role)
            ProfileInfo(
              name: 'Ade Dwi Herdiansyah',
              role: 'Informatics Student',
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Widget untuk menampilkan Avatar / Foto Profil
class ProfileAvatar extends StatelessWidget {
  final String imageUrl;

  const ProfileAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 50, backgroundImage: NetworkImage(imageUrl));
  }
}

/// Custom Widget untuk menampilkan Informasi Teks Profil
class ProfileInfo extends StatelessWidget {
  final String name;
  final String role;

  const ProfileInfo({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(role, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
