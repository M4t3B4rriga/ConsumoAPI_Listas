class Gif {
  String name;
  String url;

  Gif({required this.name, required this.url});

  @override
  String toString() {
    
    return 
"""
\nname: $name
url: $url""";
  }
}

