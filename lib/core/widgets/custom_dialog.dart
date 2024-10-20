import 'package:flutter/material.dart';

enum DialogType { success, error, warning, info }

class CustomDialog extends StatelessWidget {
  final DialogType dialogType;
  final String title;
  final String content;

  const CustomDialog({
    Key? key,
    required this.dialogType,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dialogColor;

    switch (dialogType) {
      case DialogType.success:
        dialogColor = Colors.green;
        break;
      case DialogType.error:
        dialogColor = Colors.red;
        break;
      case DialogType.warning:
        dialogColor = Colors.amber;
        break;
      case DialogType.info:
      default:
        dialogColor = Colors.blue;
        break;
    }

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            dialogType == DialogType.success
                ? Icons.check_circle
                : dialogType == DialogType.error
                    ? Icons.error
                    : dialogType == DialogType.warning
                        ? Icons.warning
                        : Icons.info,
            color: dialogColor,
          ),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(content),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: dialogColor, // Color del texto
          ),
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
        ),
      ],
    );
  }
}
