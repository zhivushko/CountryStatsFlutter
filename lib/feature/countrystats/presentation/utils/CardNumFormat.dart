
extension NumberFormatting on num {
  String formatThousand({String separator = ' '}) {
    final s = this.toString();
    final reversed = s.split('').reversed.toList();

    final chunks = <String>[];
    for (var i = 0; i < reversed.length; i += 3) {
      chunks.add(reversed.sublist(i, (i + 3).clamp(0, reversed.length)).join());
    }

    return chunks.join(separator).split('').reversed.join();
  }
}