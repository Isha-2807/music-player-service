import Foundation
import Combine

final class MusicPlayer: ObservableObject {
    static let shared = MusicPlayer()

    private init() {}

    @Published private(set) var currentSong: Song?
    @Published private(set) var isPlaying: Bool = false
    @Published var playlist: [Song] = []

    private var strategy: PlaybackStrategy?

    // MARK: - Public Methods

    func play(song: Song) {
        currentSong = song
        strategy = getStrategy(for: song)
        strategy?.play(song: song)
        isPlaying = true
    }

    func pause() {
        strategy?.pause()
        isPlaying = false
    }

    func stop() {
        strategy?.stop()
        currentSong = nil
        isPlaying = false
    }

    func skip() {
        guard let current = currentSong,
              let index = playlist.firstIndex(of: current),
              index + 1 < playlist.count else { return }
        play(song: playlist[index + 1])
    }

    func previous() {
        guard let current = currentSong,
              let index = playlist.firstIndex(of: current),
              index - 1 >= 0 else { return }
        play(song: playlist[index - 1])
    }

    // MARK: - Queue Management

    func addToQueue(song: Song) {
        playlist.append(song)
    }

    func removeFromQueue(at index: Int) {
        playlist.remove(at: index)
    }

    func moveSong(from source: Int, to destination: Int) {
        let song = playlist.remove(at: source)
        playlist.insert(song, at: destination)
    }

    private func getStrategy(for song: Song) -> PlaybackStrategy {
        switch song.source {
        case .local:
            return LocalPlayer()
        case .spotify:
            return SpotifyPlayer()
        }
    }
}
