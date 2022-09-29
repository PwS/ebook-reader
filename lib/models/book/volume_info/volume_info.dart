class VolumeInfo {
  final String title;
  final String subtitle;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final List<IndustryIdentifiers> industryIdentifiers;
  final ReadingModes readingModes;
  final int pageCount;
  final String printType;
  final List<String> categories;
  final String maturityRating;
  final bool allowAnonLogging;
  final String contentVersion;
  final PanelizationSummary panelizationSummary;
  final ImageLinks imageLinks;
  final String language;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;

  VolumeInfo(
      {required this.title,
      required this.subtitle,
      required this.authors,
      required this.publisher,
      required this.publishedDate,
      required this.description,
      required this.industryIdentifiers,
      required this.readingModes,
      required this.pageCount,
      required this.printType,
      required this.categories,
      required this.maturityRating,
      required this.allowAnonLogging,
      required this.contentVersion,
      required this.panelizationSummary,
      required this.imageLinks,
      required this.language,
      required this.previewLink,
      required this.infoLink,
      required this.canonicalVolumeLink});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
        title: json['title'],
        subtitle: json['subtitle'] ?? '',
        authors: (json['authors'] ?? <String>[]).cast<String>(),
        publisher: json['publisher'] ?? '',
        publishedDate: json['publishedDate'] ?? '',
        description: json['description'] ?? '',
        industryIdentifiers: json['industryIdentifiers'] == null
            ? <IndustryIdentifiers>[]
            : List<IndustryIdentifiers>.from(json['industryIdentifiers']
                .map((x) => IndustryIdentifiers.fromJson(x))),
        readingModes: ReadingModes.fromJson(json['readingModes']),
        pageCount: json['pageCount'] ?? 0,
        printType: json['printType'] ?? '',
        categories: (json['categories'] ?? <String>[]).cast<String>(),
        maturityRating: json['maturityRating'],
        allowAnonLogging: json['allowAnonLogging'],
        contentVersion: json['contentVersion'],
        panelizationSummary: json['panelizationSummary'] == null
            ? PanelizationSummary.empty
            : PanelizationSummary.fromJson(json['panelizationSummary']),
        imageLinks: json['imageLinks'] == null
            ? ImageLinks.empty
            : ImageLinks.fromJson(json['imageLinks']),
        language: json['language'],
        previewLink: json['previewLink'],
        infoLink: json['infoLink'],
        canonicalVolumeLink: json['canonicalVolumeLink']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['authors'] = authors;
    data['publisher'] = publisher;
    data['publishedDate'] = publishedDate;
    data['description'] = description;
    data['industryIdentifiers'] =
        industryIdentifiers.map((v) => v.toJson()).toList();
    data['readingModes'] = readingModes.toJson();
    data['pageCount'] = pageCount;
    data['printType'] = printType;
    data['categories'] = categories;
    data['maturityRating'] = maturityRating;
    data['allowAnonLogging'] = allowAnonLogging;
    data['contentVersion'] = contentVersion;
    data['panelizationSummary'] = panelizationSummary.toJson();
    data['imageLinks'] = imageLinks.toJson();
    data['language'] = language;
    data['previewLink'] = previewLink;
    data['infoLink'] = infoLink;
    data['canonicalVolumeLink'] = canonicalVolumeLink;
    return data;
  }
}

class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers({this.type, this.identifier});

  IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['identifier'] = identifier;
    return data;
  }
}

class ReadingModes {
  bool? text;
  bool? image;

  ReadingModes({this.text, this.image});

  ReadingModes.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['image'] = image;
    return data;
  }
}

class PanelizationSummary {
  final bool containsEpubBubbles;
  final bool containsImageBubbles;

  const PanelizationSummary(
      {required this.containsEpubBubbles, required this.containsImageBubbles});

  static const empty = PanelizationSummary(
      containsEpubBubbles: false, containsImageBubbles: false);

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) {
    return PanelizationSummary(
        containsEpubBubbles: json['containsEpubBubbles'] ?? false,
        containsImageBubbles: json['containsImageBubbles'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['containsEpubBubbles'] = containsEpubBubbles;
    data['containsImageBubbles'] = containsImageBubbles;
    return data;
  }
}

class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  const ImageLinks({this.smallThumbnail = '', this.thumbnail = ''});

  static const empty = ImageLinks();

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
        smallThumbnail: json['smallThumbnail'], thumbnail: json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['smallThumbnail'] = smallThumbnail;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
