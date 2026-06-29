import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  String? _selectedCategory;
  final String _location = 'Brgy. Poblacion';

  static const _categories = [
    'Announcement',
    'Lost & Found',
    'Jobs',
    'Safety',
    'For Sale',
  ];

  static const _categoryColors = {
    'Announcement': (Color(0xFFDBEAFE), Color(0xFF1D4ED8)),
    'Lost & Found': (Color(0xFFFEF3C7), Color(0xFFB45309)),
    'Jobs': (Color(0xFFDCFCE7), Color(0xFF15803D)),
    'Safety': (Color(0xFFFEE2E2), Color(0xFFB91C1C)),
    'For Sale': (Color(0xFFF3E8FF), Color(0xFF7E22CE)),
  };

  bool get _canPost =>
      _selectedCategory != null &&
      _titleController.text.trim().isNotEmpty &&
      _detailsController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
    _detailsController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map(_buildCategoryChip).toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Title',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'Enter post title',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Details',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _detailsController,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Write the details of your post...',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPhotoButton(),
                  const SizedBox(height: 20),
                  _buildLocationRow(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _canPost ? () => Navigator.pop(context) : null,
                    child: const Text('Post to Community'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 12,
        left: 4,
        right: 8,
      ),
      color: AppColors.card,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 4),
          Text(
            'New Post',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: _canPost ? () => Navigator.pop(context) : null,
            child: Text(
              'Post',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _canPost ? AppColors.primary : AppColors.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    final colors = _categoryColors[category]!;

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.$1 : AppColors.muted,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: colors.$2.withValues(alpha: 0.5))
              : null,
        ),
        child: Text(
          category,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? colors.$2 : AppColors.mutedForeground,
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.mutedForeground.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            const Icon(Icons.camera_alt_outlined,
                size: 32, color: AppColors.mutedForeground),
            const SizedBox(height: 8),
            Text(
              'Add a photo',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined,
              size: 20, color: AppColors.mutedForeground),
          const SizedBox(width: 10),
          Text(
            _location,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.black87),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Change',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
