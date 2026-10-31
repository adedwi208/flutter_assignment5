import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variabel state dinamis (tidak lagi di-hardcode di dalam StatelessWidget)
  String userName = "Ade Dwi Herdiansyah";
  String role = "Informatics Student";

  final List<String> experiences = const ["Staff Electrical Shop - Lion Air"];

  // Controller untuk menangani input dari Dialog Edit
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  // Fungsi untuk menampilkan dialog input pengubahan data profil
  void _showEditProfileDialog() {
    _nameController.text = userName;
    _roleController.text = role;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: 'Role / Pekerjaan',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Mengubah state secara dinamis menggunakan setState
                setState(() {
                  userName = _nameController.text;
                  role = _roleController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              // 1. Avatar & Tombol Edit (Aksi dipassing ke dialog input)
              ProfileAvatar(
                userName: userName,
                role: role,
                onEditPressed: _showEditProfileDialog,
              ),

              const SizedBox(height: 12),

              // 2. Teks Nama Dinamis
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 4),

              // 3. Teks Role Dinamis
              Text(
                role,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // 4. Baris Statistik
              const ProfileStats(),

              const SizedBox(height: 20),

              // 5. Judul Project Experiences
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Project Experiences",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const Divider(height: 16),

              // 6. ListView Pengalaman
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  return ExperienceCard(title: experiences[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Widget: Avatar & Tombol Edit Profile (Menerima Callback OnPressed)
class ProfileAvatar extends StatelessWidget {
  final String userName;
  final String role;
  final VoidCallback onEditPressed;

  const ProfileAvatar({
    super.key,
    required this.userName,
    required this.role,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onEditPressed,
          icon: const Icon(Icons.edit, size: 18),
          label: const Text("Edit Profile"),
        ),
      ],
    );
  }
}

/// Custom Widget: Kontainer Statistik Profil
class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatItem(count: "12", label: "Project"),
          StatItem(count: "1.2K", label: "Followers"),
          StatItem(count: "350", label: "Following"),
        ],
      ),
    );
  }
}

/// Custom Widget: Item Angka & Label Statistik
class StatItem extends StatelessWidget {
  final String count;
  final String label;

  const StatItem({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

/// Custom Widget: Card Item Pengalaman
class ExperienceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ExperienceCard({
    super.key,
    required this.title,
    this.icon = Icons.work,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
