// To parse this JSON data, do
//
//     final podcast = podcastFromMap(jsonString);

import 'dart:convert';

Podcast podcastFromMap(String str) => Podcast.fromMap(json.decode(str));

String podcastToMap(Podcast data) => json.encode(data.toMap());

class Podcast {
  String? id;
  String? title;
  String? contestantA;
  String? contestantB;
  String? sportsName;
  String? leagueName;
  String? leagueAbbrev;
  String? duration;
  String? punters;
  String? featuredVideoFile;
  String? featuredImageFile;
  String? featuredVideoId;
  String? featuredImageId;
  String? viewsCount;
  String? likesCount;
  List<Like>? likes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Podcast({
    this.id,
    this.title,
    this.contestantA,
    this.contestantB,
    this.sportsName,
    this.leagueName,
    this.leagueAbbrev,
    this.duration,
    this.punters,
    this.featuredVideoFile,
    this.featuredImageFile,
    this.featuredVideoId,
    this.featuredImageId,
    this.viewsCount,
    this.likesCount,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  factory Podcast.fromMap(Map<String, dynamic> json) => Podcast(
    id: json["id"],
    title: json["title"],
    contestantA: json["contestantA"],
    contestantB: json["contestantB"],
    sportsName: json["sportsName"],
    leagueName: json["leagueName"],
    leagueAbbrev: json["leagueAbbrev"],
    duration: json["duration"],
    punters: json["punters"],
    featuredVideoFile: json["featuredVideoFile"],
    featuredImageFile: json["featuredImageFile"],
    featuredVideoId: json["featuredVideoId"],
    featuredImageId: json["featuredImageId"],
    viewsCount: json["viewsCount"],
    likesCount: json["likesCount"],
    likes: List<Like>.from(json["likes"].map((x) => Like.fromMap(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "contestantA": contestantA,
    "contestantB": contestantB,
    "sportsName": sportsName,
    "leagueName": leagueName,
    "leagueAbbrev": leagueAbbrev,
    "duration": duration,
    "punters": punters,
    "featuredVideoFile": featuredVideoFile,
    "featuredImageFile": featuredImageFile,
    "featuredVideoId": featuredVideoId,
    "featuredImageId": featuredImageId,
    "viewsCount": viewsCount,
    "likesCount": likesCount,
    "likes": List<dynamic>.from(likes!.map((x) => x.toMap())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Like {
  Like({
    this.userId,
  });

  String? userId;

  factory Like.fromMap(Map<String, dynamic> json) => Like(
    userId: json["userId"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
  };
}

