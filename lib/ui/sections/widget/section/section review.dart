import '../../../../database/model/secttions_model.dart';
import '../../../../import.dart';

class SectionReview extends StatelessWidget {
  SectionsModel sections;

  SectionReview({required this.sections});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff49688D),

            ),
            child: Center(child: Text("الكل",style: GoogleFonts.cairo(
              color: Colors.white,
            ),)),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff49688D),

            ),
            child: Center(child: Text("${sections.name}",style: GoogleFonts.cairo(
              color: Colors.white,
            ),)),
          ),

        )
      ],
    );
  }
}
