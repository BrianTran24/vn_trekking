import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        title: const Text('VN Trekking'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Trails', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeaturesSection(context),
            _buildAboutSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        image: const DecorationImage(
          image: NetworkImage('https://via.placeholder.com/1200x600'), // Replace with actual hero image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Khám phá Việt Nam cùng VN Trekking',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Hành trình chinh phục những đỉnh cao và vẻ đẹp thiên nhiên hùng vĩ.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text('Bắt đầu ngay'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Tại sao chọn chúng tôi?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureCard(
                icon: Icons.map,
                title: 'Bản đồ chi tiết',
                description: 'Cung cấp thông tin đường đi và độ khó của từng cung đường.',
              ),
              _buildFeatureCard(
                icon: Icons.people,
                title: 'Cộng đồng lớn',
                description: 'Kết nối với những người đam mê trekking trên khắp cả nước.',
              ),
              _buildFeatureCard(
                icon: Icons.security,
                title: 'An toàn tuyệt đối',
                description: 'Hướng dẫn viên chuyên nghiệp và đội ngũ hỗ trợ 24/7.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String description}) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 50, color: Colors.green),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          const Text(
            'Về VN Trekking',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'VN Trekking là nền tảng hàng đầu dành cho những người yêu thích trekking tại Việt Nam. '
            'Chúng tôi cam kết mang đến những trải nghiệm tuyệt vời và an toàn nhất cho khách hàng.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.grey.shade900,
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            '© 2024 VN Trekking. All rights reserved.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.white70)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt, color: Colors.white70)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.email, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}
