import SwiftUI

struct PlayerView: View {
    @StateObject var viewModel = PlayerViewModel()

    var body: some View {
        VStack {
            Text("Now Playing: \(viewModel.songTitle)")
                .font(.title)

            HStack {
                Button("Prev") {
                    viewModel.previous()
                }
                Button(viewModel.isPlaying ? "Pause" : "Play") {
                    if viewModel.isPlaying {
                        viewModel.pause()
                    } else if let song = viewModel.playlist.first {
                        viewModel.play(song: song)
                    }
                }
                Button("Next") {
                    viewModel.skip()
                }
            }

            List {
                ForEach(viewModel.playlist) { song in
                    Text("\(song.title) - \(song.artist)")
                }
                .onDelete { indexSet in
                    indexSet.forEach { viewModel.remove(at: $0) }
                }
            }
        }
        .padding()
    }
}
