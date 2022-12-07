import 'dart:convert';

class SocialLink {
  final String product;
  final String url;

  SocialLink({
    required this.product,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'product': product});
    result.addAll({'url': url});

    return result;
  }

  factory SocialLink.fromMap(Map<String, dynamic> map) {
    return SocialLink(
      
       
        product:map['product'] ?? '', url:map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialLink.fromJson(String source) =>
      SocialLink.fromMap(json.decode(source));

  SocialLink copyWith({
    String? product,
    String? url,
  }) {
    return SocialLink(
     product:  product ?? this.product,
      url: url ?? this.url,
    );
  }

  @override
  String toString() => 'SocialLink(product: $product, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialLink && other.product == product && other.url == url;
  }

  @override
  int get hashCode => product.hashCode ^ url.hashCode;
}
