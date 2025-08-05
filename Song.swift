struct Song: Identifiable, Equatable {
    let id: UUID = UUID()
    let title: String
    let artist: String
    let duration: TimeInterval
    let source: MusicSource
    let url: URL? // only used by Local
}

enum MusicSource {
    case local
    case spotify
}
