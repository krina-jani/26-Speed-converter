import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
            _buildSection(
              '12. Contact Us',
              'If you have any questions or suggestions about our Privacy Policy, please contact us at:\n\nEmperor Smart Solutions\nPhone: +91 63543 51080',
            ),
            _buildSection(
              '13. Our Social Profiles',
              'Instagram:\nhttps://www.instagram.com/emperorsmartsolutions?stkn=eng4aTNpcWZqbWE=\n\nLinkedIn:\nhttps://www.linkedin.com/company/emperor-smart-solutions/',
            ),
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
