import 'package:flutter/material.dart';
import 'package:notes_offline/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onPressedUpdate;
  final void Function()? onPressedDelete;

  const NoteTile({
    super.key,
    required this.text,
    required this.onPressedDelete,
    required this.onPressedUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 10, left: 25, right: 25),
      child: ListTile(
          title: Text(text),
          trailing: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showPopover(
                width: 100,
                height: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                context: context,
                bodyBuilder: (context) => NoteSettings(
                  onDeleteTap: onPressedDelete,
                  onEditTap: onPressedUpdate,
                ),
              ),
            );
          })),
    );
  }
}

// Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // update method
//             IconButton(
//               onPressed: onPressedUpdate,
//               icon: const Icon(Icons.edit),
//             ),
//             // delet method
//             IconButton(
//               onPressed: onPressedDelete,
//               icon: const Icon(Icons.delete),
//             )
//           ],
//         ),