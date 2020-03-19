import 'package:flutter/material.dart';
import 'Bloc.dart';

/* 1
 * BlocContainer is a generic class. 
 * The generic type T is scoped to be an object 
 * that implements the Bloc interface. 
 * This means that the provider can only store 
 * BLoC objects.
 */
class BlocContainer<BlockType extends Bloc> extends StatefulWidget {
  final Widget child;
  final BlockType bloc;

  // Constructor
  const BlocContainer({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2
  static BlockType of<BlockType extends Bloc>(BuildContext context) {
    // final type = _providerType<BlocContainer<BlockType>>();
    final BlocContainer<BlockType> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  // 3
  // static Type _providerType<BlockType>() => BlockType;

  @override
  State createState() => _BlocContainerState();
}

class _BlocContainerState extends State<BlocContainer> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    this.widget.bloc.dispose();
    super.dispose();
  }
}