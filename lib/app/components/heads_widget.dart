import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class HeadWidget extends StatelessWidget {
  HeadWidget({required this.value , required this.title , required this.textStyle , required this.color});
  final dynamic value;
  final String title;
  final TextStyle textStyle;
  final PdfColor color;

  @override
  Widget build(Context context) {
    return  Container(
        color: PdfColors.white,
        child: Table(
            border: TableBorder.all(
                color: PdfColors.black, width: 1),
            children: [
              TableRow(
                  decoration: const  BoxDecoration(
                    color: PdfColors.white,
                  ),
                  children: [
                    Padding(padding: const EdgeInsets.all(2) , child: Text(
                       value != null
                            ? value.toString()
                            : "null",
                        style: textStyle,
                        textDirection:
                        TextDirection.rtl)),
                    Container(
                        color: color,
                        child: Padding(
                            padding: const EdgeInsets.all(2),
                            child:Text(title,
                                style: textStyle,
                                textDirection:
                                TextDirection.rtl , textAlign: TextAlign.center)
                        )

                    ),
                  ]),
            ]));
  }

}