import Foundation
import Combine

final class PlayerViewModel: ObservableObject {
    @Published var songTitle: String = ""
    @Published var isPlaying: Bool = false
    @Published var playlist: [Song] = []

    private var cancellables = Set<AnyCancellable>()
    private let player = MusicPlayer.shared

    init() {
        player.$currentSong
            .compactMap { $0?.title }
            .assign(to: \.songTitle, on: self)
            .store(in: &cancellables)

        player.$isPlaying
            .assign(to: \.isPlaying, on: self)
            .store(in: &cancellables)

        player.$playlist
            .assign(to: \.playlist, on: self)
            .store(in: &cancellables)
    }

    func play(song: Song) {
        player.play(song: song)
    }

    func pause() {
        player.pause()
    }

    func skip() {
        player.skip()
    }

    func previous() {
        player.previous()
    }

    func add(song: Song) {
        player.addToQueue(song: song)
    }

    func remove(at index: Int) {
        player.removeFromQueue(at: index)
    }

    func move(from: Int, to: Int) {
        player.moveSong(from: from, to: to)
    }
}
