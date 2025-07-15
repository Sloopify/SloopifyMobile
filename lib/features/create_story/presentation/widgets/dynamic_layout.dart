import 'dart:math';
import 'dart:ui';

class DynamicLayoutItem {
  final String id;
  final double aspectRatio;
  final bool isVideoFile;
  final int priority; // Higher priority = more likely to be bigger

  // Calculated properties
  double? scale;
  Offset? offset;
  double? rotation;
  Size? size;

  DynamicLayoutItem({
    required this.id,
    required this.aspectRatio,
    this.isVideoFile = false,
    this.priority = 0,
    this.scale,
    this.offset,
    this.rotation,
    this.size,
  });

  DynamicLayoutItem copyWith({
    String? id,
    double? aspectRatio,
    bool? isVideoFile,
    int? priority,
    double? scale,
    Offset? offset,
    double? rotation,
    Size? size,
  }) {
    return DynamicLayoutItem(
      id: id ?? this.id,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      isVideoFile: isVideoFile ?? this.isVideoFile,
      priority: priority ?? this.priority,
      scale: scale ?? this.scale,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      size: size ?? this.size,
    );
  }
}

class LayoutBlock {
  final List<DynamicLayoutItem> items;
  final Size blockSize;
  final Offset blockOffset;
  final double height; // Relative height units for column balancing

  LayoutBlock({
    required this.items,
    required this.blockSize,
    required this.blockOffset,
    required this.height,
  });
}

class DynamicWrapLayoutAlgorithm {
  static const double baseImageSize = 180.0;
  static const double minImageSize = 120.0;
  static const double maxImageSize = 280.0;
  static const double padding = 8.0;

  /// Main algorithm to calculate dynamic wrap layout
  static List<DynamicLayoutItem> calculateDynamicLayout({
    required List<DynamicLayoutItem> items,
    required Size screenSize,
    double toolbarOffset = 68.0,
  }) {
    if (items.isEmpty) return [];

    // Calculate available space
    final availableWidth = screenSize.width - (toolbarOffset * 2);
    final availableHeight = screenSize.height - (toolbarOffset * 2);
    final availableSize = Size(availableWidth, availableHeight);

    // Sort items by priority (higher priority first)
    final sortedItems = List<DynamicLayoutItem>.from(items)
      ..sort((a, b) => b.priority.compareTo(a.priority));

    // Apply different algorithms based on item count
    if (items.length == 1) {
      return _layoutSingleItem(sortedItems, availableSize, toolbarOffset);
    } else if (items.length <= 4) {
      return _layoutSmallGroup(sortedItems, availableSize, toolbarOffset);
    } else if (items.length <= 10) {
      return _layoutMediumGroup(sortedItems, availableSize, toolbarOffset);
    } else {
      return _layoutLargeGroup(sortedItems, availableSize, toolbarOffset);
    }
  }

  /// Layout for single item - full screen with dynamic scaling
  static List<DynamicLayoutItem> _layoutSingleItem(
      List<DynamicLayoutItem> items,
      Size availableSize,
      double toolbarOffset,
      ) {
    final item = items.first;
    final scale = _calculateOptimalScale(item.aspectRatio, availableSize);
    final size = Size(baseImageSize * scale, baseImageSize * scale);

    return [
      item.copyWith(
        scale: scale,
        offset: Offset(
          toolbarOffset + availableSize.width * 0.5,
          toolbarOffset + availableSize.height * 0.5,
        ),
        size: size,
        rotation: 0.0,
      ),
    ];
  }

  /// Layout for 2-4 items using Facebook-inspired algorithm
  static List<DynamicLayoutItem> _layoutSmallGroup(
      List<DynamicLayoutItem> items,
      Size availableSize,
      double toolbarOffset,
      ) {
    final List<DynamicLayoutItem> result = [];
    final columns = _createColumns(2, availableSize.height);
    final stash = <DynamicLayoutItem>[];

    for (final item in items) {
      final shouldBeBig = _shouldItemBeBig(item, items);

      if (shouldBeBig) {
        final column = _getSmallestColumn(columns);
        final scale = _calculateDynamicScale(item, true, items.length);
        final size = Size(baseImageSize * scale, baseImageSize * scale);
        final offset = _calculateColumnOffset(column, availableSize, toolbarOffset, size);

        result.add(item.copyWith(
          scale: scale,
          offset: offset,
          size: size,
          rotation: _calculateDynamicRotation(item),
        ));

        column.height += 2.0;
      } else {
        stash.add(item);
        if (stash.length == 2) {
          final column = _getSmallestColumn(columns);
          final scale = _calculateDynamicScale(stash.first, false, items.length);
          final size = Size(baseImageSize * scale, baseImageSize * scale);

          // Position two small items side by side
          final baseOffset = _calculateColumnOffset(column, availableSize, toolbarOffset, size);

          result.add(stash[0].copyWith(
            scale: scale,
            offset: Offset(baseOffset.dx - size.width * 0.3, baseOffset.dy),
            size: size,
            rotation: _calculateDynamicRotation(stash[0]),
          ));

          result.add(stash[1].copyWith(
            scale: scale,
            offset: Offset(baseOffset.dx + size.width * 0.3, baseOffset.dy),
            size: size,
            rotation: _calculateDynamicRotation(stash[1]),
          ));

          column.height += 1.0;
          stash.clear();
        }
      }
    }

    // Handle remaining items in stash
    if (stash.isNotEmpty) {
      final column = _getSmallestColumn(columns);
      final scale = _calculateDynamicScale(stash.first, false, items.length);
      final size = Size(baseImageSize * scale, baseImageSize * scale);
      final baseOffset = _calculateColumnOffset(column, availableSize, toolbarOffset, size);

      for (int i = 0; i < stash.length; i++) {
        result.add(stash[i].copyWith(
          scale: scale,
          offset: Offset(
            baseOffset.dx + (i == 0 ? -size.width * 0.3 : size.width * 0.3),
            baseOffset.dy,
          ),
          size: size,
          rotation: _calculateDynamicRotation(stash[i]),
        ));
      }
    }

    return result;
  }

  /// Layout for 5-10 items using advanced packing algorithm
  static List<DynamicLayoutItem> _layoutMediumGroup(
      List<DynamicLayoutItem> items,
      Size availableSize,
      double toolbarOffset,
      ) {
    return _layoutWithBinPacking(items, availableSize, toolbarOffset, 3);
  }

  /// Layout for 10+ items using grid-based packing
  static List<DynamicLayoutItem> _layoutLargeGroup(
      List<DynamicLayoutItem> items,
      Size availableSize,
      double toolbarOffset,
      ) {
    return _layoutWithBinPacking(items, availableSize, toolbarOffset, 4);
  }

  /// Advanced bin packing algorithm for medium to large groups
  static List<DynamicLayoutItem> _layoutWithBinPacking(
      List<DynamicLayoutItem> items,
      Size availableSize,
      double toolbarOffset,
      int maxColumns,
      ) {
    final List<DynamicLayoutItem> result = [];
    final columns = _createColumns(maxColumns, availableSize.height);

    // Create blocks of varying sizes based on priority and aspect ratio
    final blocks = _createDynamicBlocks(items, availableSize);

    for (final block in blocks) {
      final column = _getSmallestColumn(columns);
      final blockOffset = Offset(
        toolbarOffset + (column.index * (availableSize.width / maxColumns)) +
            (availableSize.width / maxColumns) * 0.5,
        toolbarOffset + column.height * (baseImageSize + padding),
      );

      // Position items within the block
      for (int i = 0; i < block.items.length; i++) {
        final item = block.items[i];
        final itemOffset = _calculateItemOffsetInBlock(
          i,
          block.items.length,
          blockOffset,
          block.blockSize,
        );

        result.add(item.copyWith(
          scale: item.scale,
          offset: itemOffset,
          size: item.size,
          rotation: item.rotation,
        ));
      }

      column.height += block.height;
    }

    return result;
  }

  /// Create dynamic blocks based on item properties
  static List<LayoutBlock> _createDynamicBlocks(
      List<DynamicLayoutItem> items,
      Size availableSize,
      ) {
    final List<LayoutBlock> blocks = [];
    final List<DynamicLayoutItem> remaining = List.from(items);

    while (remaining.isNotEmpty) {
      final blockItems = <DynamicLayoutItem>[];
      final firstItem = remaining.removeAt(0);
      blockItems.add(firstItem);

      // Determine block type based on first item priority
      if (_shouldItemBeBig(firstItem, items)) {
        // Single big item block
        final scale = _calculateDynamicScale(firstItem, true, items.length);
        final size = Size(baseImageSize * scale, baseImageSize * scale);

        blocks.add(LayoutBlock(
          items: [firstItem.copyWith(scale: scale, size: size, rotation: _calculateDynamicRotation(firstItem))],
          blockSize: size,
          blockOffset: Offset.zero, // Will be calculated later
          height: 2.0,
        ));
      } else {
        // Multi-item block
        final blockSize = min(3, remaining.length + 1);
        while (blockItems.length < blockSize && remaining.isNotEmpty) {
          blockItems.add(remaining.removeAt(0));
        }

        final scale = _calculateDynamicScale(firstItem, false, items.length);
        final size = Size(baseImageSize * scale, baseImageSize * scale);

        // Apply scale and rotation to all items in block
        final processedItems = blockItems.map((item) => item.copyWith(
          scale: scale,
          size: size,
          rotation: _calculateDynamicRotation(item),
        )).toList();

        blocks.add(LayoutBlock(
          items: processedItems,
          blockSize: Size(size.width * 1.5, size.height),
          blockOffset: Offset.zero, // Will be calculated later
          height: 1.0,
        ));
      }
    }

    return blocks;
  }

  /// Calculate optimal scale based on aspect ratio and available space
  static double _calculateOptimalScale(double aspectRatio, Size availableSize) {
    final widthScale = availableSize.width / (baseImageSize * aspectRatio);
    final heightScale = availableSize.height / baseImageSize;
    final optimalScale = min(widthScale, heightScale) * 0.8; // 80% of available space

    return optimalScale.clamp(minImageSize / baseImageSize, maxImageSize / baseImageSize);
  }

  /// Calculate dynamic scale based on item properties and context
  static double _calculateDynamicScale(DynamicLayoutItem item, bool isBig, int totalItems) {
    double baseScale = isBig ? 1.2 : 0.8;

    // Adjust based on total items
    if (totalItems > 6) baseScale *= 0.8;
    else if (totalItems > 4) baseScale *= 0.9;

    // Adjust based on aspect ratio
    if (item.aspectRatio > 1.5) baseScale *= 0.9; // Wide images slightly smaller
    else if (item.aspectRatio < 0.7) baseScale *= 0.9; // Tall images slightly smaller

    // Add slight randomization for natural look
    final randomFactor = 0.9 + (Random().nextDouble() * 0.2); // 0.9 to 1.1
    baseScale *= randomFactor;

    return baseScale.clamp(minImageSize / baseImageSize, maxImageSize / baseImageSize);
  }

  /// Calculate dynamic rotation for natural look
  static double _calculateDynamicRotation(DynamicLayoutItem item) {
    // Add slight rotation based on item ID for consistency
    final hash = item.id.hashCode;
    final rotation = (hash % 21 - 10) * 0.01; // -0.1 to 0.1 radians (~-6 to 6 degrees)
    return rotation;
  }

  /// Determine if an item should be displayed as big based on priority
  static bool _shouldItemBeBig(DynamicLayoutItem item, List<DynamicLayoutItem> allItems) {
    if (allItems.length <= 2) return true;

    // Top 30% of items by priority should be big
    final sortedByPriority = List<DynamicLayoutItem>.from(allItems)
      ..sort((a, b) => b.priority.compareTo(a.priority));

    final bigItemCount = max(1, (allItems.length * 0.3).round());
    final bigItems = sortedByPriority.take(bigItemCount);

    return bigItems.contains(item);
  }

  /// Create column structure for layout
  static List<_Column> _createColumns(int count, double availableHeight) {
    return List.generate(count, (index) => _Column(index, 0.0));
  }

  /// Get the column with smallest height
  static _Column _getSmallestColumn(List<_Column> columns) {
    return columns.reduce((a, b) => a.height < b.height ? a : b);
  }

  /// Calculate offset for item in a column
  static Offset _calculateColumnOffset(
      _Column column,
      Size availableSize,
      double toolbarOffset,
      Size itemSize,
      ) {
    final columnWidth = availableSize.width / 2; // Assuming 2 columns for now
    final x = toolbarOffset + (column.index * columnWidth) + (columnWidth * 0.5);
    final y = toolbarOffset + column.height * (baseImageSize + padding) + (itemSize.height * 0.5);

    return Offset(x, y);
  }

  /// Calculate item offset within a block
  static Offset _calculateItemOffsetInBlock(
      int itemIndex,
      int totalItems,
      Offset blockOffset,
      Size blockSize,
      ) {
    if (totalItems == 1) {
      return blockOffset;
    } else if (totalItems == 2) {
      final xOffset = itemIndex == 0 ? -blockSize.width * 0.25 : blockSize.width * 0.25;
      return Offset(blockOffset.dx + xOffset, blockOffset.dy);
    } else {
      // For 3+ items, arrange in a small grid
      final cols = totalItems <= 4 ? 2 : 3;
      final row = itemIndex ~/ cols;
      final col = itemIndex % cols;

      final xOffset = (col - (cols - 1) / 2) * (blockSize.width / cols);
      final yOffset = (row - 0.5) * (blockSize.height / 2);

      return Offset(blockOffset.dx + xOffset, blockOffset.dy + yOffset);
    }
  }
}

/// Helper class for column management
class _Column {
  final int index;
  double height;

  _Column(this.index, this.height);
}

