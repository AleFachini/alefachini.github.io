import 'package:flutter/material.dart';

/// Placeholder for the Certificates section.
///
/// Will be fully implemented in Phase 3 with image gallery
/// and inline PDF rendering via PDF.js.
class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certificates coming soon...',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
