import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TypeAheadFormField<T> extends StatefulWidget {
  final InputDecoration? decorator;
  final String? noItemFoundText;
  final String? initialValue;
  final double overlayHeight;
  final ValueChanged<T> onSuggestionSelected;
  final String? Function(String? val)? validator;
  final Iterable<T> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final TextFieldConfiguration textFieldConfiguration;

  const TypeAheadFormField({
    Key? key,
    required this.onSuggestionSelected,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.textFieldConfiguration,
    this.validator,
    this.overlayHeight = 300,
    this.decorator,
    this.initialValue,
    this.noItemFoundText,
  }) : super(key: key);

  @override
  _DropdownTextSearch createState() => _DropdownTextSearch<T>();
}

class _DropdownTextSearch<T> extends State<TypeAheadFormField<T>> {
  late final ScrollController scrollController;
  late final FocusNode focusNode;
  final layerLink = LayerLink();
  OverlayEntry? entry;
  int _selectedItem = -1;
  String text = "";
  bool isHovering = false;
  static List<OverlayEntry> entries = [];

  List<T> get items => widget.suggestionsCallback(text).toList();

  @override
  void initState() {
    scrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    widget.textFieldConfiguration.focusNode?.addListener(() {
      if(widget.textFieldConfiguration.focusNode!.hasFocus){
        entry?.markNeedsBuild();
      }
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
      } else {
        if(!isHovering) {
          hideOverlay();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    focusNode.dispose();
    entry?.remove();
    entry?.dispose();
    super.dispose();
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    for (var element in entries) {
      if(element.mounted) {
        element.remove();
      }
    }
    entries.clear();
    entry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
          width: size.width, child: CompositedTransformFollower(link: layerLink, showWhenUnlinked: true, offset: Offset(0, size.height + 10), child: buildOverlay())),
    );

    overlay.insert(entry!);
    entries.add(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() {
    return Material(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.overlayHeight,minHeight: 50),
          child: items.isNotEmpty
              ? MouseRegion(
                onEnter: (_) => isHovering = true,
                onExit: (_) => isHovering = false,
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Listener(
                          // onPointerUp: (d){
                          //   focusNode.unfocus();
                          //   widget.onSuggestionSelected(items[index]);
                          // },
                          child: ListTile(
                            title: Text(items[index].toString()),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            hoverColor: Colors.grey.shade100,
                            tileColor: index == _selectedItem ? (Colors.grey.shade200) : Colors.transparent,
                            onTap: () {
                              focusNode.unfocus();
                              widget.onSuggestionSelected(items[index]);
                            },
                          ),
                        );
                      },
                      itemCount: items.length,
                    ),
                ),
              )
              : Center(child: Text(widget.noItemFoundText ?? "No Item Found")),
        ));
  }

  void scrollFun() {
    if(items.length <= 2) return;
    double perBlockHeight = scrollController.position.maxScrollExtent / (items.length - 1);
    double _position = _selectedItem * perBlockHeight;
    scrollController.jumpTo(
      _position,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (RawKeyEvent key) {
        if (key.isKeyPressed(LogicalKeyboardKey.enter)) {
          if(_selectedItem != -1) {
            widget.onSuggestionSelected(widget.suggestionsCallback(text).toList()[_selectedItem]);
            focusNode.unfocus();
          }
        } else if (key.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          _selectedItem = _selectedItem < items.length - 1 ? _selectedItem + 1 : _selectedItem;
          scrollFun();
        } else if (key.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          _selectedItem = _selectedItem > -1 ? _selectedItem - 1 : _selectedItem;
          if (_selectedItem != -1) {
            scrollFun();
          }
        } else if (key.isKeyPressed(LogicalKeyboardKey.escape)) {
          if (widget.textFieldConfiguration.controller != null) {
            widget.textFieldConfiguration.controller!.clear();
          }
          focusNode.unfocus();
        } else if (key.isKeyPressed(LogicalKeyboardKey.tab)) {
          focusNode.unfocus();
        }
        entry!.markNeedsBuild();
      },
      child: CompositedTransformTarget(
        link: layerLink,
        child: TextFormField(
          controller: widget.textFieldConfiguration.controller,
          autofocus: false,
          initialValue: widget.initialValue,
          validator: widget.validator,
          onFieldSubmitted: _selectedItem == -1 ? widget.textFieldConfiguration.onSubmitted : null,
          cursorColor: Colors.black,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
          onChanged: (val) {
            text = val;
            widget.textFieldConfiguration.onChanged?.call(val);
            _selectedItem = -1;
            entry!.markNeedsBuild();
          },
          onTap: _selectedItem == -1?widget.textFieldConfiguration.onTap:null,
          textDirection: widget.textFieldConfiguration.textDirection,
          textAlignVertical: widget.textFieldConfiguration.textAlignVertical,
          textInputAction: widget.textFieldConfiguration.textInputAction,
          focusNode: widget.textFieldConfiguration.focusNode,
          decoration: widget.textFieldConfiguration.decoration ?? const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
        ),
      ),
    );
  }
}

class TextFieldConfiguration {
  TextFieldConfiguration({
    this.controller,
    this.focusNode,
    this.onSubmitted,
    this.decoration,
    this.textInputAction,
    this.textDirection,
    this.onChanged,
    this.onTap,
    this.textAlignVertical,
  });

  final InputDecoration? decoration;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? onSubmitted;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final TextAlignVertical? textAlignVertical;
}
