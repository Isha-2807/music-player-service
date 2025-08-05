class SpotifyPlayer: PlaybackStrategy {
    func play(song: Song) {
        print("Simulated playing from Spotify: \(song.title)")
    }

    func pause() {
        print("Paused Spotify playback")
    }

    func stop() {
        print("Stopped Spotify playback")
    }
}
