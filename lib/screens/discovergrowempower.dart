import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  
  final PageController _pageController = PageController();

  
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                
                OnboardingPageContent(
                  imagePath: 'assets/images/discover.png',
                  title: 'Discover new skills',
                ),
                
                OnboardingPageContent(
                  imagePath: 'assets/images/grow.png',
                  title: 'Grow together',
                ),
                
                OnboardingPageContent(
                  imagePath: 'assets/images/empower.png',
                  title: 'Empower other',
                ),
              ],
            ),
          ),

          
          _buildPageIndicator(),
          const SizedBox(height: 40),

          
          
          
          Container(
            height: 120, 
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            
            child: _currentPage == 2
                ? Column(
                    children: [
                      
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/signup');
                          },
                          child: const Text('Get Started'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        width: 300,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/login');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6a87c8),
                            shape: const StadiumBorder(),
                            side: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor,
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(), 
          ),

          const SizedBox(height: 20), 
        ],
      ),
    );
  }

  
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 60, 
          height: 8, 
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            
            color: _currentPage == index
                ? Theme.of(context).primaryColor 
                : Colors.grey[300], 
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}





class OnboardingPageContent extends StatelessWidget {
  final String imagePath;
  final String title;

  const OnboardingPageContent({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2), 
          Image.asset(
            imagePath,
            height: 300, 
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3), 
        ],
      ),
    );
  }
}