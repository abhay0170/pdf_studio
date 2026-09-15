import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../shared/utils/file_size_formatter.dart';
import '../models/document_model.dart';
import 'document_type_icon.dart';

/// One row in the document list: name, metadata, a PDF icon, a trailing
/// more-menu button, and iOS-style swipe actions (Share / Rename / Delete)
/// revealed only when the row is dragged left.
class DocumentCard extends StatefulWidget {
  const DocumentCard({
    super.key,
    required this.document,
    this.onTap,
    this.onMore,
    this.onShare,
    this.onRename,
    this.onDelete,
  });

  final DocumentModel document;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  final VoidCallback? onShare;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> with SingleTickerProviderStateMixin {
  static const double _actionsWidth = 210;

  late final AnimationController _controller;
  double _dragExtent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    final begin = _dragExtent;
    late final VoidCallback listener;
    listener = () {
      setState(() {
        _dragExtent = begin + (target - begin) * Curves.easeOutCubic.transform(_controller.value);
      });
      if (_controller.isCompleted) _controller.removeListener(listener);
    };
    _controller.addListener(listener);
    _controller.forward(from: 0);
  }

  void _close() {
    if (_dragExtent != 0) _animateTo(0);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent = (_dragExtent + details.delta.dx).clamp(-_actionsWidth, 0.0);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final shouldOpen = velocity < -250 || (_dragExtent < -_actionsWidth / 2 && velocity < 250);
    _animateTo(shouldOpen ? -_actionsWidth : 0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final doc = widget.document;
    // docCardBackground is translucent in dark mode (a glass effect over the
    // screen background elsewhere) — resolve it to an opaque color here so
    // the foreground layer fully occludes the swipe actions behind it.
    final cardBackground = Color.alphaBlend(colors.docCardBackground, colors.screenBackground);

    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                const Spacer(),
                _ActionButton(
                  icon: Icons.ios_share_rounded,
                  label: 'Share',
                  background: colors.docBadgeIcon,
                  foreground: Colors.white,
                  onTap: () {
                    _close();
                    widget.onShare?.call();
                  },
                ),
                _ActionButton(
                  icon: Icons.edit_rounded,
                  label: 'Rename',
                  background: colors.cardFlatBackground,
                  foreground: colors.cardSubtitleMuted,
                  onTap: () {
                    _close();
                    widget.onRename?.call();
                  },
                ),
                _ActionButton(
                  icon: Icons.delete_rounded,
                  label: 'Delete',
                  background: colors.destructive,
                  foreground: Colors.white,
                  onTap: () {
                    _close();
                    widget.onDelete?.call();
                  },
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(_dragExtent, 0),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              onTap: _dragExtent == 0 ? widget.onTap : _close,
              child: Material(
                color: cardBackground,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  child: SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        const DocumentTypeIcon(),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600, color: colors.docTitle),
                              ),
                              const SizedBox(height: 4),
                              Text(_meta(doc), style: TextStyle(fontSize: 12.5, color: colors.docMeta)),
                              const SizedBox(height: 2),
                              Text(
                                _formatDate(doc.modifiedAt),
                                style: TextStyle(fontSize: 11.5, color: colors.docMeta.withValues(alpha: 0.8)),
                              ),
                            ],
                          ),
                        ),
                        Semantics(
                          label: 'More options for ${doc.name}',
                          button: true,
                          child: IconButton(
                            onPressed: widget.onMore,
                            icon: Icon(Icons.more_vert_rounded, color: colors.docMeta),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Material(
        color: background,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foreground, size: 20),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: foreground)),
            ],
          ),
        ),
      ),
    );
  }
}

String _meta(DocumentModel doc) {
  final pages = doc.pageCount == 1 ? '1 page' : '${doc.pageCount} pages';
  return '$pages · ${formatFileSize(doc.sizeBytes)}';
}

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _formatDate(DateTime date) {
  final now = DateTime.now();
  final time = _formatTime(date);

  if (_isSameDay(date, now)) return 'Today, $time';

  final yesterday = now.subtract(const Duration(days: 1));
  if (_isSameDay(date, yesterday)) return 'Yesterday, $time';

  return '${_months[date.month - 1]} ${date.day}, ${date.year}';
}

bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String _formatTime(DateTime date) {
  final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
  final minute = date.minute.toString().padLeft(2, '0');
  final period = date.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}
