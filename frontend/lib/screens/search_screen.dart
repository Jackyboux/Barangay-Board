import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';

class SearchScreen extends StatefulWidget {
  final List<PostData> allPosts;

  const SearchScreen({super.key, required this.allPosts});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  final Set<String> _activeFilters = {};
  final List<String> _recentSearches = [
    'Road clearing',
    'Lost dog',
    'Medical mission',
  ];

  static const _categories = [
    'Announcements',
    'Lost & Found',
    'Jobs',
    'Safety',
    'For Sale',
  ];

  static const _categoryColors = {
    'Announcements': (Color(0xFFDBEAFE), Color(0xFF1D4ED8)),
    'Lost & Found': (Color(0xFFFEF3C7), Color(0xFFB45309)),
    'Jobs': (Color(0xFFDCFCE7), Color(0xFF15803D)),
    'Safety': (Color(0xFFFEE2E2), Color(0xFFB91C1C)),
    'For Sale': (Color(0xFFF3E8FF), Color(0xFF7E22CE)),
  };

  String get _query => _searchController.text.trim();

  List<PostData> get _results {
    var posts = widget.allPosts;

    if (_activeFilters.isNotEmpty) {
      posts = posts.where((p) => _activeFilters.contains(p.category)).toList();
    }

    if (_query.isEmpty) return [];

    final q = _query.toLowerCase();
    return posts
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.body.toLowerCase().contains(q) ||
            p.author.toLowerCase().contains(q))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterChips(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 14,
        left: 4,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                style: GoogleFonts.inter(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search posts...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                  prefixIcon: const Icon(Icons.search,
                      color: AppColors.mutedForeground, size: 20),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close,
                              size: 18, color: AppColors.mutedForeground),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  filled: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isActive = _activeFilters.contains(category);
          final colors = _categoryColors[category]!;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isActive) {
                    _activeFilters.remove(category);
                  } else {
                    _activeFilters.add(category);
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? colors.$1 : AppColors.muted,
                  borderRadius: BorderRadius.circular(20),
                  border: isActive
                      ? Border.all(color: colors.$2.withValues(alpha: 0.4))
                      : null,
                ),
                child: Text(
                  category,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isActive ? colors.$2 : AppColors.mutedForeground,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_query.isEmpty) {
      return _buildRecentSearches();
    }

    final results = _results;

    if (results.isEmpty) {
      return _buildNoResults();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${results.length} result${results.length == 1 ? '' : 's'} found',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.mutedForeground,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: results.length,
            itemBuilder: (context, index) {
              return PostCard(post: results[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent searches',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ..._recentSearches.map(
            (search) => InkWell(
              onTap: () {
                _searchController.text = search;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.history,
                        size: 20, color: AppColors.mutedForeground),
                    const SizedBox(width: 12),
                    Text(
                      search,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 48, color: AppColors.mutedForeground),
          const SizedBox(height: 12),
          Text(
            'No results found',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.mutedForeground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try a different search term or filter',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
