import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyGridView extends StatelessWidget {
  final ScrollController scrollController;
  final List myUsersList;
  const MyGridView(
      {super.key, required this.scrollController, required this.myUsersList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      controller: scrollController,
      itemCount: myUsersList.length,
      itemBuilder: (context, index) {
        final user = myUsersList[index];
        final login = user.name;
        final avatar_url = user.imageUrl;
        return GestureDetector(
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/user', arguments: user);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(248, 203, 208, 212), // Серый фон
                  borderRadius: BorderRadius.circular(10), // Закругление углов
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipOval(
                                  child:
                                      Image(image: NetworkImage(avatar_url))),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Форма контейнера - круг
                            color: Color.fromARGB(
                                255, 0, 80, 19), // Цвет контейнера
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        login,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          onTap: () {},
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}
