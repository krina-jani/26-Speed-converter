import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/social_icons.dart';
import 'privacy_policy_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(BuildContext context, String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        launched = await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      }
      if (!launched && context.mounted) {
        _showSnackBar(context, 'Could not open link: $urlString');
      }
    } catch (e) {
      if (context.mounted) {
        try {
          final bool launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
          if (!launched && context.mounted) {
            _showSnackBar(context, 'Unable to open link.');
          }
        } catch (_) {
          if (context.mounted) {
            _showSnackBar(context, 'Unable to open link.');
          }
        }
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Very dark navy
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About SpeedShift',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Logo & Branding
            Center(
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFF38BDF8).withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/icons/speedshift_logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.speed,
                          size: 48,
                          color: Color(0xFF38BDF8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'SpeedShift',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Version 1.0.0 • Offline Speed Utility',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Legal & Governance Section
            _buildSectionHeader('Legal & Governance'),
            const SizedBox(height: 10),
            _buildCardTile(
              icon: Icons.shield_outlined,
              iconBgColor: const Color(0xFF0284C7),
              title: 'Privacy Policy',
              subtitle: 'Read full data safety practices & privacy policy',
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF94A3B8),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // Connect With Us Section
            _buildSectionHeader('Connect With Us'),
            const SizedBox(height: 10),

            // Instagram Card
            _buildCardTile(
              iconWidget: const InstagramIcon(size: 24),
              iconBgColor: const Color(0xFFE1306C),
              title: 'Instagram',
              subtitle: 'Follow Emperor Smart Solutions',
              trailing: const Icon(
                Icons.open_in_new,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
              onTap: () => _launchURL(
                context,
                'https://www.instagram.com/emperorsmartsolutions?stkn=eng4aTNpcWZqbWE=',
              ),
            ),
            const SizedBox(height: 12),

            // Facebook Card
            _buildCardTile(
              iconWidget: const FacebookIcon(size: 24),
              iconBgColor: const Color(0xFF1877F2),
              title: 'Facebook',
              subtitle: 'Follow Emperor Smart Solutions',
              trailing: const Icon(
                Icons.open_in_new,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
              onTap: () => _launchURL(
                context,
                'https://www.facebook.com/emperorsmartsolutions',
              ),
            ),
            const SizedBox(height: 12),

            // LinkedIn Card
            _buildCardTile(
              iconWidget: const LinkedInIcon(size: 24),
              iconBgColor: const Color(0xFF0A66C2),
              title: 'LinkedIn',
              subtitle: 'Follow Emperor Smart Solutions',
              trailing: const Icon(
                Icons.open_in_new,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
              onTap: () => _launchURL(
                context,
                'https://www.linkedin.com/company/emperor-smart-solutions/',
              ),
            ),
            const SizedBox(height: 12),

            // Contact Us Card
            _buildCardTile(
              icon: Icons.phone_in_talk,
              iconBgColor: const Color(0xFF10B981),
              title: 'Contact Us',
              subtitle: '+91 63543 51080',
              trailing: const Icon(
                Icons.phone,
                color: Color(0xFF10B981),
                size: 20,
              ),
              onTap: () => _launchURL(
                context,
                'tel:+916354351080',
              ),
            ),

            const SizedBox(height: 28),

            // Developer Section
            _buildSectionHeader('Developer'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF334155),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.business_outlined,
                      color: Color(0xFF818CF8),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emperor Smart Solutions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Emperor Smart Solutions develops software, mobile applications, digital products, and utility applications.',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF38BDF8),
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildCardTile({
    IconData? icon,
    Widget? iconWidget,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF334155),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBgColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: iconWidget ??
                      Icon(
                        icon,
                        color: iconBgColor,
                        size: 22,
                      ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
