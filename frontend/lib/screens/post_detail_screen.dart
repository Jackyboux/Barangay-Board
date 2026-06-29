import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';

class CommentData {
  final String author;
  final String initials;
  final String text;
  final String timeAgo;

  const CommentData({
    required this.author,
    required this.initials,
    required this.text,
    required this.timeAgo,
  });
}

class PostDetailScreen extends StatefulWidget {
  final PostData post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _commentController = TextEditingController();

  static const _categoryColors = {
    'Announcements': (Color(0xFFDBEAFE), Color(0xFF1D4ED8)),
    'Lost & Found': (Color(0xFFFEF3C7), Color(0xFFB45309)),
    'Jobs': (Color(0xFFDCFCE7), Color(0xFF15803D)),
    'Safety': (Color(0xFFFEE2E2), Color(0xFFB91C1C)),
    'For Sale': (Color(0xFFF3E8FF), Color(0xFF7E22CE)),
  };

  final List<CommentData> _comments = const [
    CommentData(
      author: 'Ana Gonzales',
      initials: 'AG',
      text: 'Salamat sa info! Will share this with the neighbors.',
      timeAgo: '1h ago',
    ),
    CommentData(
      author: 'Pedro Reyes',
      initials: 'PR',
      text: 'Is there a contact number for more details?',
      timeAgo: '45m ago',
    ),
    CommentData(
      author: 'Liza Cruz',
      initials: 'LC',
      text: 'Thank you for the update, Kapitan! 🙏',
      timeAgo: '30m ago',
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSafety = widget.post.category == 'Safety';
    final headerColor = isSafety ? AppColors.destructive : AppColors.primary;
    final badgeColors = _categoryColors[widget.post.category] ??
        (const Color(0xFFE5E7EB), const Color(0xFF374151));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(headerColor),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          widget.post.initials,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.author,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${widget.post.timeAgo} · ${widget.post.barangay}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.mutedForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColors.$1,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.post.category,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: badgeColors.$2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.post.title,
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.post.body,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border,
                          size: 20, color: AppColors.mutedForeground),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.post.likes}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.chat_bubble_outline,
                          size: 19, color: AppColors.mutedForeground),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.post.comments + _comments.length}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.share_outlined,
                          size: 19, color: AppColors.mutedForeground),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 16),
                  Text(
                    'Comments',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._comments.map(_buildComment),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildHeader(Color color) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 16,
        left: 4,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
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
          Text('Post Details', style: AppTheme.heading(size: 18)),
        ],
      ),
    );
  }

  Widget _buildComment(CommentData comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.muted,
            child: Text(
              comment.initials,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.mutedForeground,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.author,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        comment.timeAgo,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment.text,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.4,
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

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _commentController,
                style: GoogleFonts.inter(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  filled: false,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send_rounded,
                color: AppColors.primary, size: 24),
          ),
        ],
      ),
    );
  }
}
