import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedIconButton extends StatefulWidget {
  final String? url;
  final String assetName;
  final String semanticsLabel;

  const AnimatedIconButton({
    Key? key,
    this.url,
    required this.assetName,
    required this.semanticsLabel,
  }) : super(key: key);

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
  Future<void> _launchUrl() async {
    if (widget.url == null) {
      return;
    }

    if (!await launchUrl(Uri.parse(widget.url!),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${widget.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _launchUrl,
      iconSize: 40,
      icon: SvgPicture.asset(
        widget.assetName,
        semanticsLabel: widget.semanticsLabel,
      ),
    );
  }
}
