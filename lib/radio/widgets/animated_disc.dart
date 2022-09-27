import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_test/radio/cubit/radio_player_cubit.dart';
import 'package:labhouse_test/theme/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AnimatedDisc extends StatefulWidget {
  const AnimatedDisc({
    this.size = 55,
  }) : super(key: const ValueKey('disc_rotating'));

  final double size;

  @override
  State<AnimatedDisc> createState() => _AnimatedDiscState();
}

class _AnimatedDiscState extends State<AnimatedDisc>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RadioPlayerCubit, RadioPlayerState>(
      listenWhen: (prev, curr) => prev.isPlaying != curr.isPlaying,
      listener: (context, state) {
        final _isPlaying = state.isPlaying;
        if (!_isPlaying) {
          controller.stop();
        } else {
          controller.repeat();
        }
      },
      child: Hero(
        tag: 'disc',
        child: Icon(
          PhosphorIcons.discFill,
          size: widget.size,
          color: AppTheme.primaryLight,
        )
            .animate(
              controller: controller,
              onComplete: (controller) {
                final _isPlaying =
                    context.read<RadioPlayerCubit>().state.isPlaying;

                if (!_isPlaying) {
                  controller.stop();
                } else {
                  controller.forward(from: 0);
                }
              },
            )
            .rotate(
              curve: Curves.easeInOut,
              duration: 1.seconds,
            ),
      ),
    );
  }
}
