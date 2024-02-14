import 'package:fai/database/model/add_post_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final AddPostModel addPostModel;

  const PostWidget({Key? key, required this.addPostModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy hh:mm a');
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${addPostModel.title}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${addPostModel.content}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _showFullScreenImage(context, addPostModel.photo);
              },
              child: addPostModel.photo != null
                  ? InteractiveViewer(
                child: Image.network(
                  addPostModel.photo!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              )
                  : Container(
                width: double.infinity,
                height: 30,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(addPostModel.dateTime ?? DateTime.now()),
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String? imageUrl) {
    if (imageUrl != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: InteractiveViewer(
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      );
    }
  }
}
