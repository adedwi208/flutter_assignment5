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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Custom Widget 1: ProfileAvatar
              const ProfileAvatar(imageUrl: ''),
              const SizedBox(height: 16),

              // Custom Widget 2: ProfileInfo
              const ProfileInfo(
                name: 'Ade Dwi Herdiansyah',
                role: 'Informatics Student',
              ),
              const SizedBox(height: 16),

              // Tombol Edit Profil
              ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol ditekan
                },
                child: const Text('Edit Profil'),
              ),
              const SizedBox(height: 24),

              const Divider(),
              const SizedBox(height: 16),

              // Layout Row dengan Expanded & Extract Widget
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ProfileStatItem(value: '3', label: 'Proyek'),
                  ),
                  Expanded(
                    child: ProfileStatItem(value: '4.5M', label: 'Followers'),
                  ),
                  Expanded(
                    child: ProfileStatItem(value: '350', label: 'Following'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Widget 1: Avatar / Foto Profil
class ProfileAvatar extends StatelessWidget {
  final String imageUrl;

  const ProfileAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 50, backgroundImage: NetworkImage(imageUrl));
  }
}

/// Custom Widget 2: Informasi Teks Profil
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

/// Custom Widget 3: Item Statistik (Angka + Label)
class ProfileStatItem extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
