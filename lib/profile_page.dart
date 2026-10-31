import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // GlobalKey untuk menangani validasi Form di dalam Dialog
  final _formKey = GlobalKey<FormState>();

  // State variabel dinamis
  String userName = "Ade Dwi Herdiansyah";
  String role = "Informatics Student";

  final List<String> experiences = const ["Staff Electrical Shop - Lion Air"];

  // Controller untuk membaca input dari TextFormField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  // Fungsi memunculkan Dialog Edit Profil dengan TextFormField
  void _showEditProfileDialog() {
    _nameController.text = userName;
    _roleController.text = role;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextFormField untuk nama pengguna
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // TextFormField untuk role / pekerjaan
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'Role / Pekerjaan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Role tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validasi input TextFormField
                if (_formKey.currentState!.validate()) {
                  // Memperbarui state userName & role di layar utama
                  setState(() {
                    userName = _nameController.text.trim();
                    role = _roleController.text.trim();
                  });
                  Navigator.pop(context);
                }
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
              // 1. Profile Avatar & Tombol Edit
              ProfileAvatar(
                userName: userName,
                role: role,
                onEditPressed: _showEditProfileDialog,
              ),

              const SizedBox(height: 12),

              // 2. Nama Lengkap Dinamis
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 4),

              // 3. Role / Subtitle Dinamis
              Text(
                role,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // 4. Baris Statistik Profil
              const ProfileStats(),

              const SizedBox(height: 20),

              // 5. Header Judul Project Experiences
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Project Experiences",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const Divider(height: 16),

              // 6. ListView Daftar Pengalaman
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

/// Custom Widget: Avatar & Tombol Edit Profile
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

/// Custom Widget: Baris Statistik Profil
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
          StatItem(count: "3", label: "Project"),
          StatItem(count: "4.5M", label: "Followers"),
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
