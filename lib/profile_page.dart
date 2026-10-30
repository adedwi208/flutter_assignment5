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
              // Custom Widget: ProfileAvatar
              const ProfileAvatar(imageUrl: ''),
              const SizedBox(height: 16),

              // Custom Widget: ProfileInfo
              const ProfileInfo(
                name: 'Ade Dwi Herdiansyah',
                role: 'Informatics Student',
              ),
              const SizedBox(height: 16),

              // Tombol Edit Profil
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit Profil'),
              ),
              const SizedBox(height: 24),

              const Divider(),
              const SizedBox(height: 16),

              // Custom Widget Hasil Ekstraksi: ProfileStats
              const ProfileStats(
                projects: '3',
                followers: '4.5M',
                following: '350',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Widget: Avatar / Foto Profil
class ProfileAvatar extends StatelessWidget {
  final String imageUrl;

  const ProfileAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 50, backgroundImage: NetworkImage(imageUrl));
  }
}

/// Custom Widget: Informasi Teks Profil
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

/// Custom Widget Komposisi: ProfileStats
/// Membungkus Row, Expanded, dan beberapa StatItem sekaligus
class ProfileStats extends StatelessWidget {
  final String projects;
  final String followers;
  final String following;

  const ProfileStats({
    super.key,
    required this.projects,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: StatItem(value: projects, label: 'Proyek'),
        ),
        Expanded(
          child: StatItem(value: followers, label: 'Followers'),
        ),
        Expanded(
          child: StatItem(value: following, label: 'Following'),
        ),
      ],
    );
  }
}

/// Custom Widget Atom: StatItem (Item Statistik Individu)
class StatItem extends StatelessWidget {
  final String value;
  final String label;

  const StatItem({super.key, required this.value, required this.label});

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
