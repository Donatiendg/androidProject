class Game {
  final String name;
  final String price;
  final String shortDesc;
  final String desc;
  final String backgroundImage;
  final String frontImage;
  final List<String> screenImage;
  final String editor;
  final int id;
  final int rank;
  bool ?liked;
  bool ?wish;

  Game(this.id, this.rank, this.name, this.editor, this.price, this.shortDesc, this.desc, this.backgroundImage, this.frontImage, this.screenImage, {this.liked, this.wish});


  @override
  String toString() {
    return 'Game{name: $name, id: $id, rank: $rank, price: $price, imageUrl: $backgroundImage}';
  }
}