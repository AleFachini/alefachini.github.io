import 'package:flutter/material.dart';
import '../../data/portfolio_data.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: projects.map((project) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies.map((tech) {
                  return Chip(
                    label: Text(
                      tech,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
