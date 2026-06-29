import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';
import 'create_post_screen.dart';
import 'post_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  static const _categories = [
    'All',
    'Announcements',
    'Lost & Found',
    'Jobs',
    'Safety',
    'For Sale',
  ];

  static const _samplePosts = [
    PostData(
      author: 'Barangay Hall',
      barangay: 'Brgy. Poblacion',
      timeAgo: '2h ago',
      category: 'Announcements',
      title: 'Road Clearing Operations This Saturday',
      body:
          'All residents are advised that road clearing operations will take place this Saturday along Rizal Avenue. Please remove any obstructions before 6 AM.',
      likes: 34,
      comments: 8,
      initials: 'BH',
    ),
    PostData(
      author: 'Maria Santos',
      barangay: 'Brgy. Poblacion',
      timeAgo: '4h ago',
      category: 'Lost & Found',
      title: 'Lost: Brown Labrador near Palengke',
      body:
          'My brown Labrador named Bantay went missing this morning near the palengke area. He is wearing a red collar with a tag. Please contact me if found!',
      likes: 12,
      comments: 5,
      initials: 'MS',
    ),
    PostData(
      author: 'Juan dela Cruz',
      barangay: 'Brgy. Poblacion',
      timeAgo: '5h ago',
      category: 'Safety',
      title: 'ALERT: Flooded road at Maharlika St.',
      body:
          'Maharlika Street is currently impassable due to flooding. MDRRMO is on-site. Please use alternate routes via Quezon Ave.',
      likes: 56,
      comments: 23,
      initials: 'JC',
    ),
    PostData(
      author: 'Jollibee Poblacion',
      barangay: 'Brgy. Poblacion',
      timeAgo: '6h ago',
      category: 'Jobs',
      title: 'Now Hiring: Service Crew (Part-time)',
      body:
          'Jollibee Poblacion is looking for part-time service crew members. Must be 18+, willing to work shifts. Apply in-store or send your resume.',
      likes: 20,
      comments: 3,
      initials: 'JP',
    ),
    PostData(
      author: 'Rosa Reyes',
      barangay: 'Brgy. San Isidro',
      timeAgo: '8h ago',
      category: 'For Sale',
      title: 'Ukay-Ukay Bundle — Kids Clothes',
      body:
          'Selling pre-loved kids clothes in good condition. Bundle of 10 pieces for ₱200. Pickup only at Brgy. San Isidro. DM for photos!',
      likes: 8,
      comments: 2,
      initials: 'RR',
    ),
    PostData(
      author: 'Kapitan Reyes',
      barangay: 'Brgy. Poblacion',
      timeAgo: '1d ago',
      category: 'Announcements',
      title: 'Free Medical Mission — June 25',
      body:
          'Free medical and dental checkup at the Barangay Hall on June 25. Open to all residents. Please bring your Barangay ID. Salamat sa info!',
      likes: 45,
      comments: 11,
      initials: 'KR',
    ),
  ];

  List<PostData> get _filteredPosts {
    if (_selectedCategory == 0) return _samplePosts;
    final category = _categories[_selectedCategory];
    return _samplePosts.where((p) => p.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          _buildCategoryTabs(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredPosts[index];
                return PostCard(
                  post: post,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 14,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Barangay Board', style: AppTheme.heading(size: 20)),
              const Spacer(),
              Stack(
                children: [
                  const Icon(Icons.notifications_outlined,
                      color: Colors.white, size: 26),
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white24,
                child:
                    Icon(Icons.person_outline, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 14),
              const SizedBox(width: 4),
              Text(
                'Brgy. Poblacion',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchScreen(allPosts: _samplePosts),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white70, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Search posts...',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = index),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.muted,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _categories[index],
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.mutedForeground,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
