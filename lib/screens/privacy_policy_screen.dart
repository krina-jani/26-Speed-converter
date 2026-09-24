import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/social_icons.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
      backgroundColor: const Color(0xFF0F172A), // Dark Navy
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Effective Date: September 21, 2026\nLast Updated: September 21, 2026',
              style: TextStyle(
                color: Color(0xFF38BDF8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              '1. Information We Collect',
              'SpeedShift is designed as a local, offline utility application. We do NOT collect, store, or transmit any personal information, location data, contact details, device identifiers, or user input values. All calculations performed within SpeedShift are computed locally on your device and are never sent to external servers.',
            ),
            _buildSection(
              '2. Advertising and Third-Party Services',
              'SpeedShift does not contain any third-party advertisements, ad networks, tracking beacons, or commercial promotional services. We do not partner with ad providers or monetize your app usage through data collection.',
            ),
            _buildSection(
              '3. Analytics and Other Third-Party Services',
              'We do not integrate third-party analytics frameworks, crash reporting tools, or telemetry services (such as Firebase Analytics, Google Analytics, or Mixpanel). Your app usage remains completely private to your device.',
            ),
            _buildSection(
              '4. How We Use Information',
              'Because no data is collected, transmitted, or stored on external servers, SpeedShift does not process or use your personal information in any manner.',
            ),
            _buildSection(
              '5. Data Sharing',
              'We do not sell, rent, trade, or share any user data with third parties. No data leaves your mobile device.',
            ),
            _buildSection(
              '6. Data Security',
              'All calculation inputs, selected units, and conversion history (if stored locally) are maintained strictly within your device\'s sandbox memory. Since no data is transmitted over the internet, your information is secure from online interception.',
            ),
            _buildSection(
              '7. Data Retention and Deletion',
              'SpeedShift does not store personal data on cloud servers or external databases. Uninstalling the application completely removes all locally cached preferences from your device.',
            ),
            _buildSection(
              '8. Children\'s Privacy',
              'SpeedShift is suitable for users of all ages, including children. We do not knowingly collect or request personal information from children under the age of 13 (or any other age group).',
            ),
            _buildSection(
              '9. Permissions',
              'SpeedShift operates without requiring any sensitive Android permissions. It does NOT request internet access, location permissions, camera access, storage access, or contacts access.',
            ),
            _buildSection(
              '10. External Links',
              'The About section of SpeedShift contains external links to our official social media profiles (Instagram and LinkedIn) and contact phone number. When you tap these links, you will be redirected to external platforms governed by their respective privacy policies.',
            ),
            _buildSection(
              '11. Changes to This Privacy Policy',
              'We may update our Privacy Policy periodically. Any changes will be reflected with a revised Effective Date at the top of this screen.',
            ),
            
            // 12. Contact Us Section with Working Phone Link
            _buildSectionHeader('12. Contact Us'),
            const SizedBox(height: 6),
            const Text(
              'If you have any questions or suggestions about our Privacy Policy, please contact us at:\n\nEmperor Smart Solutions',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL(context, 'tel:+916354351080'),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone, color: Color(0xFF10B981), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Phone: +91 63543 51080',
                      style: TextStyle(
                        color: Color(0xFF38BDF8),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 13. Our Social Profiles Section with Working Instagram, Facebook & LinkedIn Links
            _buildSectionHeader('13. Our Social Profiles'),
            const SizedBox(height: 10),
            
            // Instagram Link Button
            InkWell(
              onTap: () => _launchURL(
                context,
                'https://www.instagram.com/emperorsmartsolutions?stkn=eng4aTNpcWZqbWE=',
              ),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: const Row(
                  children: [
                    InstagramIcon(size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Instagram: https://www.instagram.com/emperorsmartsolutions',
                        style: TextStyle(
                          color: Color(0xFF38BDF8),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.open_in_new, color: Color(0xFF38BDF8), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Facebook Link Button
            InkWell(
              onTap: () => _launchURL(
                context,
                'https://www.facebook.com/emperorsmartsolutions',
              ),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: const Row(
                  children: [
                    FacebookIcon(size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Facebook: https://www.facebook.com/emperorsmartsolutions',
                        style: TextStyle(
                          color: Color(0xFF38BDF8),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.open_in_new, color: Color(0xFF38BDF8), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // LinkedIn Link Button
            InkWell(
              onTap: () => _launchURL(
                context,
                'https://www.linkedin.com/company/emperor-smart-solutions/',
              ),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: const Row(
                  children: [
                    LinkedInIcon(size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'LinkedIn: https://www.linkedin.com/company/emperor-smart-solutions/',
                        style: TextStyle(
                          color: Color(0xFF38BDF8),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.open_in_new, color: Color(0xFF38BDF8), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildSection(
              '14. Application-Specific Information',
              'SpeedShift is a speed conversion and speed-distance-time calculation tool developed by Emperor Smart Solutions for fast, offline calculations.',
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                '© 2026 Emperor Smart Solutions. All rights reserved.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFF94A3B8), // Muted Blue Gray
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
