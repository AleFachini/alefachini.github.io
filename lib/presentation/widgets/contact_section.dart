import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/portfolio_data.dart';

/// Placeholder for the Contact section / footer.
///
/// Will be polished in Phase 2. For now shows basic social links.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Get in Touch',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ProfileData.githubUrl.isNotEmpty)
              _SocialButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                onTap: () => _launchUrl(ProfileData.githubUrl),
              ),
            if (ProfileData.linkedInUrl.isNotEmpty) ...[
              const SizedBox(width: 16),
              _SocialButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                onTap: () => _launchUrl(ProfileData.linkedInUrl),
              ),
            ],
            if (ProfileData.email.isNotEmpty) ...[
              const SizedBox(width: 16),
              _SocialButton(
                icon: FontAwesomeIcons.envelope,
                label: 'Email',
                onTap: () => _launchUrl('mailto:${ProfileData.email}'),
              ),
            ],
          ],
        ),
        const SizedBox(height: 40),
        Text(
          '© ${DateTime.now().year} ${ProfileData.name}. Built with Flutter.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? primaryColor
                  : primaryColor.withValues(alpha: 0.3),
            ),
            color: _isHovered
                ? primaryColor.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 18,
                color: _isHovered ? primaryColor : null,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _isHovered ? primaryColor : null,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
