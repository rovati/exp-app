import 'package:exp/model/home_list.dart';
import 'package:exp/model/list_info.dart';
import 'package:exp/screen/expense_screen.dart';
import 'package:exp/util/constant/animations.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListInfoTile extends StatefulWidget {
  final ListInfo info;

  const ListInfoTile(this.info, {Key? key}) : super(key: key);

  @override
  _ListInfoTileState createState() => _ListInfoTileState();
}

class _ListInfoTileState extends State<ListInfoTile> {
  late bool _isSelected;
  final BoxDecoration normalDec = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue.shade300, Colors.blue.shade200],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(20),
  );
  final BoxDecoration selectedDec = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.red),
  );

  @override
  void initState() {
    super.initState();
    _isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => _onTapOpenList(context),
      onLongPress: _onLongPressShowDelete,
      child: AnimatedContainer(
        duration: Animations.animDur,
        alignment: Alignment.center,
        height: 63,
        decoration: _isSelected ? selectedDec : normalDec,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: AnimatedSwitcher(
            duration: Animations.animDur,
            child: _isSelected
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _onTapDeselect,
                        child: Text(Strings.cancel, style: TextStyles.lRed20),
                      ),
                      Text(Strings.sep, style: TextStyles.red32),
                      GestureDetector(
                        onTap: _onTapDelete,
                        child: Text(Strings.delete, style: TextStyles.red20),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.info.name.toUpperCase(),
                              style: TextStyles.white20),
                          Text(
                              Strings.infoThisMonth +
                                  widget.info.monthTotal.toStringAsFixed(2),
                              style: TextStyles.white15),
                        ],
                      ),
                      Text(widget.info.total.toStringAsFixed(2),
                          style: TextStyles.white30),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _onTapOpenList(BuildContext context) {
    if (!_isSelected) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ExpenseScreen(
            info: widget.info,
          ),
        ),
      );
    }
  }

  void _onLongPressShowDelete() {
    setState(() {
      _isSelected = true;
    });
  }

  void _onTapDeselect() {
    setState(() {
      _isSelected = false;
    });
  }

  void _onTapDelete() {
    _onTapDeselect();
    HomeList().remove(widget.info);
  }
}
