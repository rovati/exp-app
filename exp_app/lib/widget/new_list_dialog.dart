import 'package:exp/model/home_list.dart';
import 'package:exp/model/list_info.dart';
import 'package:exp/util/constant/strings.dart';
import 'package:exp/util/constant/text_styles.dart';
import 'package:exp/util/id_provider.dart';
import 'package:flutter/material.dart';

/// Widget for user input when creating new expense lists.
/// It allows choosing a name for the list.
class NewListDialog extends StatefulWidget {
  final void Function() fadeoutCallback;
  const NewListDialog({Key? key, required this.fadeoutCallback})
      : super(key: key);

  @override
  NewListDialogState createState() => NewListDialogState();
}

class NewListDialogState extends State<NewListDialog> {
  final TextEditingController _contrTitle = TextEditingController();
  Gradient blueGr = LinearGradient(
      colors: [Colors.blue, Colors.blue.shade200],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _contrTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: _contrTitle,
                maxLength: 15,
                style: const TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: Strings.nedTitle,
                  hintStyle: TextStyles.blueI,
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: widget.fadeoutCallback,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 120,
                      child: Text(Strings.cancel, style: TextStyles.white15),
                    ),
                  ),
                  InkWell(
                    onTap: _onTapCreateNewList,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: blueGr,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 120,
                      child: Text(Strings.confirm, style: TextStyles.white15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapCreateNewList() async {
    final name = _contrTitle.text.isEmpty ? Strings.nldName : _contrTitle.text;
    HomeList().add(ListInfo(name, await IDProvider.getNextId()));
    widget.fadeoutCallback();
  }
}
