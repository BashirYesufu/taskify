class Project {
  String? artist;
  num? ticketPrice;
  String? duration;
  String? location;
  String? locationHex;
  DateTime? eventDate;
  String? ticketRef;
  num? quantityAvailable;
  bool? purchased;
  DateTime? purchasedAt;

  Project({
    this.artist,
    this.ticketPrice,
    this.duration,
    this.location,
    this.locationHex,
    this.eventDate,
    this.ticketRef,
    this.quantityAvailable,
    this.purchased,
    this.purchasedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Project && runtimeType == other.runtimeType && ticketRef == other.ticketRef;
  }

  @override
  int get hashCode => ticketRef.hashCode;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    artist: json["artist"],
    ticketPrice: json["ticket_price"],
    duration: json["duration"],
    location: json["location"],
    locationHex: json["location_hex"],
    eventDate: json["event_date"] == null ? null : DateTime.parse(json["event_date"]),
    ticketRef: json["ticket_ref"],
    quantityAvailable: json["quantity_available"],
    purchased: json["purchased"],
    purchasedAt: json["purchased_at"] == null ? null : DateTime.parse(json["purchased_at"]),
  );

  Map<String, dynamic> toJson() => {
    "artist": artist,
    "ticket_price": ticketPrice,
    "duration": duration,
    "location": location,
    "location_hex": locationHex,
    "event_date": eventDate?.toIso8601String(),
    "ticket_ref": ticketRef,
    "quantity_available": quantityAvailable,
    "purchased": purchased,
    "purchased_at": purchasedAt,
  };
}