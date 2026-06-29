import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PostData {
  final String author;
  final String barangay;
  final String timeAgo;
  final String category;
  final String title;
  final String body;
  final String? imageUrl;
  final int likes;
  final int comments;
  final String initials;

  const PostData({
    required this.author,
    required this.barangay,
    required this.timeAgo,
    required this.category,
    required this.title,
    required this.body,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.initials,
  });
}

class PostCard extends StatelessWidget {
  final PostData post;
  final VoidCallback? onTap;

  const PostCard({super.key, required this.post, this.onTap});

  static const _categoryColors = {
    'Announcements': (Color(0xFFDBEAFE), Color(0xFF1D4ED8)),
    'Lost & Found': (Color(0xFFFEF3C7), Color(0xFFB45309)),
    'Jobs': (Color(0xFFDCFCE7), Color(0xFF15803D)),
    'Safety': (Color(0xFFFEE2E2), Color(0xFFB91C1C)),
    'For Sale': (Color(0xFFF3E8FF), Color(0xFF7E22CE)),
  };

  @override
  Widget build(BuildContext context) {
    final isSafety = post.category == 'Safety';
    final colors = _categoryColors[post.category] ??
        (const Color(0xFFE5E7EB), const Color(0xFF374151));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSafety)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: AppColors.destructive,
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Safety Alert',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          post.initials,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.author,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${post.timeAgo} · ${post.barangay}',
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
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: colors.$1,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      post.category,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colors.$2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.title,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border,
                          size: 18, color: AppColors.mutedForeground),
                      const SizedBox(width: 4),
                      Text(
                        '${post.likes}',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: AppColors.mutedForeground),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.chat_bubble_outline,
                          size: 17, color: AppColors.mutedForeground),
                      const SizedBox(width: 4),
                      Text(
                        '${post.comments}',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: AppColors.mutedForeground),
                      ),
                      const Spacer(),
                      const Icon(Icons.share_outlined,
                          size: 17, color: AppColors.mutedForeground),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
