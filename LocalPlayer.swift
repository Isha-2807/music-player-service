import AVFoundation

class LocalPlayer: NSObject, PlaybackStrategy {
    private var player: AVAudioPlayer?

    func play(song: Song) {
        guard let url = song.url else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing local file: \(error)")
        }
    }

    func pause() {
        player?.pause()
    }

    func stop() {
        player?.stop()
        player = nil
    }
}
