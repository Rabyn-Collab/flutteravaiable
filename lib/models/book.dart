



final data = [
  {
    'imageUrl':'https://upload.wikimedia.org/wikipedia/en/thumb/4/46/Edmund_Dulac_-_The_Mermaid_-_The_Prince.jpg/220px-Edmund_Dulac_-_The_Mermaid_-_The_Prince.jpg',
    'title': 'The Little Mermaid',
    'detail': 'The Little Mermaid lives in an underwater kingdom with her widowed father (Mer-King), her dowager grandmother, and her five older sisters, each of whom had been born one year apart. When a mermaid turns fifteen, she is permitted to swim to the surface for the first time to catch a glimpse of the world above, and when the sisters become old enough, each of them visits the upper world one at a time every 365 days. As each returns, the Little Mermaid listens longingly to their various descriptions of the world inhabited by human beings. ',
    'rating':'⭐⭐⭐⭐⭐',
    'genre': 'Fairy Tales'
  },
  {
    'imageUrl':'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1651710803i/23437156.jpg',
    'title': 'Six of Crows',
    'detail': 'Ketterdam: a bustling hub of international trade where anything can be had for the right price—and no one knows that better than criminal prodigy Kaz Brekker. Kaz is offered a chance at a deadly heist that could make him rich beyond his wildest dreams. But he can’t pull it off alone',
    'rating':'⭐⭐⭐⭐',
    'genre': 'classic'
  },
  {
    'imageUrl':'https://images-na.ssl-images-amazon.com/images/I/51EGSCV5TRL._SX405_BO1,204,203,200_.jpg',
    'title': 'The Book of Witches',
    'detail': 'Witches have been a story-telling staple in world culture for thousands of years, and are more popular than ever thanks to their high profile in hugely successful TV, film and book series such as Harry Potter, and C.S. Lewis\' classic The Lion, The Witch and the Wardrobe. Witches examines many of the most famous witches from history and mythology in detail, with biographical data and notes on their abilities and achievements. The book also investigates',
    'rating':'⭐⭐⭐⭐',
    'genre': 'horror'
  },

];




class Book{
  
  final String title;
  final String imageUrl;
  final String  detail;
  final String rating;
  final String genre;
  
  Book({
   required this.imageUrl,
   required this.detail,
   required this.genre,
   required this.rating,
   required this.title 
   });
  
  
  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
        imageUrl: json['imageUrl'],
        detail: json['detail'],
        genre: json['genre'],
        rating: json['rating'],
        title: json['title']
    );
  }
  
  
}


List<Book> books = data.map((e) => Book.fromJson(e)).toList();