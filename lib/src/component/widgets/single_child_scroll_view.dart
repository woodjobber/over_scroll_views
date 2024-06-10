part of 'package:over_scroll_views/src/assembly/widgets/single_child_scroll_view.dart';

class NestedMaterialSingleChildScrollView extends SingleChildScrollView {
  /// 是否缓存可滚动页面，不缓存可能导致页面在嵌套滚动时被销毁导致手势事件丢失
  final bool wantKeepAlive;

  const NestedMaterialSingleChildScrollView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.padding,
    super.primary,
    super.physics,
    super.controller,
    super.child,
    super.dragStartBehavior,
    super.clipBehavior,
    super.restorationId,
    super.keyboardDismissBehavior,
    this.wantKeepAlive = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child;
    final Widget widget = super.build(context);
    if (widget is NotificationListener<ScrollUpdateNotification>) {
      child = NotificationListener<ScrollUpdateNotification>(
        onNotification: widget.onNotification,
        child: OverscrolMateriallScrollable.from(widget.child as Scrollable),
      );
    } else if (widget is PrimaryScrollController) {
      child = PrimaryScrollController.none(
        child: OverscrolMateriallScrollable.from(widget.child as Scrollable),
      );
    } else {
      child = OverscrolMateriallScrollable.from(widget as Scrollable);
    }
    return WrapperKeepAlive(wantKeepAlive: wantKeepAlive, child: child);
  }
}
