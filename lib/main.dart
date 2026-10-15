import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

const Color primary = Color(0xFF4F46E5);
const Color background = Color(0xFFF6F7FC);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student E-Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: background,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!email.contains('@') || !email.contains('.') || password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid email and a password of at least 4 characters.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PortfolioPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 850),
              child: Card(
                elevation: 8,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth > 600;

                    final intro = Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      color: primary,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.white, size: 42),
                          SizedBox(height: 14),
                          Text(
                            'MY E-PORTFOLIO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 22),
                          ProfileAvatar(radius: 58),
                          SizedBox(height: 16),
                          Text(
                            'Ritika Somagoni',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Computer Science Engineering Student',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'My journey, my skills, my achievements.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );

                    final form = Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome!',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text('Login to explore my portfolio.'),
                          const SizedBox(height: 24),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => hidePassword = !hidePassword);
                                },
                                icon: Icon(
                                  hidePassword ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                            ),
                            onSubmitted: (_) => login(),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Demo login: use any valid email and a password with at least 4 characters.',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    );

                    if (wide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: intro),
                          Expanded(child: form),
                        ],
                      );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [intro, form],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  void scrollToSection(BuildContext context, String sectionName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scroll down to the $sectionName section.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        title: const Text(
          'Ritika | My Portfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE0E7FF), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  const ProfileAvatar(radius: 72),
                  const SizedBox(height: 18),
                  const Text(
                    'Hello, I am Ritika!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Computer Science Engineering Student',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'I am passionate about technology, programming, problem-solving and learning new skills.',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.6),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: () => scrollToSection(context, 'Certificates'),
                        icon: const Icon(Icons.workspace_premium),
                        label: const Text('My Certificates'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => scrollToSection(context, 'About Me'),
                        icon: const Icon(Icons.person_outline),
                        label: const Text('About Me'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            portfolioSection(
              'About Me',
              'A little introduction',
              const Text(
                'I am a B.Tech Computer Science and Engineering student. I enjoy learning programming, exploring technology and building projects that help me develop practical skills. I believe in continuous learning and improving through practice and collaboration.',
                style: TextStyle(fontSize: 16, height: 1.8),
              ),
            ),
            portfolioSection(
              'Education',
              'My academic journey',
              const InfoCard(
                icon: Icons.school,
                title: 'B.Tech in Computer Science and Engineering',
                description: 'College: Add your college name\nGraduation year: 2028\nAdd your academic details here.',
              ),
            ),
            portfolioSection(
              'Technical Skills',
              'Technologies I am learning',
              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SkillChip('Java', Icons.code),
                  SkillChip('Flutter', Icons.phone_android),
                  SkillChip('Dart', Icons.terminal),
                  SkillChip('HTML', Icons.web),
                  SkillChip('CSS', Icons.palette_outlined),
                  SkillChip('Problem Solving', Icons.psychology),
                ],
              ),
            ),
            
portfolioSection(
  'Achievements',
  'My milestones and accomplishments',
  TweenAnimationBuilder<double>(
    tween: Tween<double>(begin: 0, end: 1),
    duration: const Duration(milliseconds: 900),
    curve: Curves.easeOut,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: child,
        ),
      );
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/leetcode_100_days.jpg',
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Achievement image not found. Check the filename.'),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '100 Days of Coding - LeetCode',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Completed 100 days of coding practice on LeetCode, '
            'demonstrating consistency and dedication to improving '
            'my programming and problem-solving skills.',
            style: TextStyle(fontSize: 15, height: 1.7),
          ),
        ],
      ),
    ),
  ),
),

            
portfolioSection(
  'Certificates',
  'My learning and achievements',
  const Column(
    children: [
      CertificateCard(
        title: 'Certificate 1',
        issuer: 'Add course or organization name',
        description: 'Add your certificate details here.',
        imagePath: 'assets/images/certificate1.jpg',
        delay: 0,
      ),
      SizedBox(height: 16),
      CertificateCard(
        title: 'Certificate 2',
        issuer: 'Add course or organization name',
        description: 'Describe what you learned.',
        imagePath: 'assets/images/certificate2.jpg',
        delay: 200,
      ),
      SizedBox(height: 16),
      CertificateCard(
        title: 'Certificate 3',
        issuer: 'Add course or organization name',
        description: 'Add your achievement details.',
        imagePath: 'assets/images/certificate3.jpg',
        delay: 400,
      ),
    ],
  ),
),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              color: const Color(0xFFE0E7FF),
              child: const Column(
                children: [
                  Text(
                    'Thank You!',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: primary),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Thank you for visiting my student portfolio.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text('Contact: Replace with your preferred email'),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              color: const Color(0xFF20233A),
              child: const Text(
                '© 2026 Ritika Somagoni | Student E-Portfolio',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileAvatar extends StatelessWidget {
  final double radius;

  const ProfileAvatar({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFC7D2FE),
      backgroundImage: const AssetImage('assets/images/ritika.jpg'),
    );
  }
}


Widget portfolioSection(String title, String subtitle, Widget content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: primary),
            ),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 22),
            content,
          ],
        ),
      ),
    ),
  );
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const SkillChip(this.label, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: primary, size: 20),
      label: Text(label),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFDDE1F0)),
      padding: const EdgeInsets.all(8),
    );
  }
}

class ActivityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActivityChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: primary),
      label: Text(label),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFDDE1F0)),
      padding: const EdgeInsets.all(10),
    );
  }
}


class CertificateCard extends StatelessWidget {
  final String title;
  final String issuer;
  final String description;
  final String imagePath;
  final int delay;

  const CertificateCard({
    super.key,
    required this.title,
    required this.issuer,
    required this.description,
    required this.imagePath,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800 + delay),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 25 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: const Color(0xFFE0E7FF),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('Certificate image not found'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(issuer, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(height: 1.5)),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                showGeneralDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Certificate details',
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (dialogContext, animation, secondaryAnimation) {
                    return Center(
                      child: Dialog(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 550),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Image.asset(
                                    imagePath,
                                    height: 280,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text(
                                        'Certificate image not found. Check the filename.',
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    issuer,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    description,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    );

                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: curvedAnimation,
                        child: child,
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('View Certificate Details'),
            ),
          ],
        ),
      ),
    );
  }
}
