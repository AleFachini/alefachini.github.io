import 'package:flutter/material.dart';

/// Placeholder for the Projects section.
///
/// Will be fully implemented in Phase 2 with project cards,
/// tech tags, and embedded YouTube video support.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects coming soon...',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
