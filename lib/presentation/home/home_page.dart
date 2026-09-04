import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/navigation_provider.dart';
import '../shared/scroll_to_section.dart';
import '../widgets/certificates_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/side_navigation_panel.dart';

/// The main portfolio page.
///
/// A single scrollable page containing all sections (Hero, Projects,
/// Certificates, Contact) with a side navigation panel overlay.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for scroll targeting.
  final _heroKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _certificatesKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// Updates the active section based on scroll position.
  void _onScroll() {
    final sections = [
      (key: _heroKey, section: PortfolioSection.hero),
      (key: _projectsKey, section: PortfolioSection.projects),
      (key: _certificatesKey, section: PortfolioSection.certificates),
      (key: _contactKey, section: PortfolioSection.contact),
    ];

    for (final entry in sections.reversed) {
      final context = entry.key.currentContext;
      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox?;
      if (box == null) continue;

      final position = box.localToGlobal(Offset.zero);
      // Consider a section "active" when its top is within the upper
      // third of the viewport.
      if (position.dy <= MediaQuery.of(this.context).size.height * 0.4) {
        ref.read(activeSectionProvider.notifier).setSection(entry.section);
        break;
      }
    }
  }

  /// Smooth-scroll to the given section.
  void _scrollToSection(PortfolioSection section) {
    final key = switch (section) {
      PortfolioSection.hero => _heroKey,
      PortfolioSection.projects => _projectsKey,
      PortfolioSection.certificates => _certificatesKey,
      PortfolioSection.contact => _contactKey,
    };
    ScrollToSection.scrollTo(key, _scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content.
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero section — full-height, no wrapper needed (custom bg).
                SectionWrapper(
                  sectionKey: _heroKey,
                  addVerticalPadding: false,
                  child: const HeroSection(),
                ),

                // Projects section.
                SectionWrapper(
                  sectionKey: _projectsKey,
                  title: 'Projects',
                  child: const ProjectsSection(),
                ),

                // Certificates section.
                SectionWrapper(
                  sectionKey: _certificatesKey,
                  title: 'Certificates',
                  child: const CertificatesSection(),
                ),

                // Contact section.
                SectionWrapper(
                  sectionKey: _contactKey,
                  title: 'Contact',
                  child: const ContactSection(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),

          // Side navigation overlay.
          SideNavigationPanel(
            onSectionTap: _scrollToSection,
          ),
        ],
      ),
    );
  }
}
