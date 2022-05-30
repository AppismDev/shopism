import 'package:flutter/material.dart';

class SelectableCard extends StatefulWidget {
  VoidCallback onTap;
  bool isSelected = false;
  String imageUrl;
  String text;

  SelectableCard({Key? key, required this.imageUrl, required this.text, required this.isSelected, required this.onTap}) : super(key: key);

  @override
  State<SelectableCard> createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: widget.isSelected ? Border.all(color: Colors.green, width: 2) : Border(),
        ),
        child: ListTile(
          leading: Image.network(
            widget.imageUrl,
            errorBuilder: (context, error, stackTrace) =>
                Image.network("https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png"),
          ),
          title: Text(widget.text ?? ""),
        ),
      ),
    );
  }
}
