import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Text(
            AppLocalizations.of(context)!.heroTitle,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.heroSubtitle,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              context.push('/trails');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: Text(AppLocalizations.of(context)!.startNow),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            l10n.whyChooseUs,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.push('/trails');
                },
                child: _buildFeatureCard(
                  icon: Icons.map,
                  title: l10n.detailedMaps,
                  description: l10n.detailedMapsDesc,
                ),
              ),
              _buildFeatureCard(
                icon: Icons.people,
                title: l10n.largeCommunity,
                description: l10n.largeCommunityDesc,
              ),
              _buildFeatureCard(
                icon: Icons.security,
                title: l10n.absoluteSafety,
                description: l10n.absoluteSafetyDesc,
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Text(
            l10n.aboutTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.aboutDesc,
            style: const TextStyle(fontSize: 16),
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
