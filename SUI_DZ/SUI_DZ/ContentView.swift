//
//  ContentView.swift
//  SUI_DZ
//
//  Created by Ксения Шилина on 29.04.2024.
//
import AVFoundation
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published public var maxDuration: TimeInterval = 0.0
    @Published public var currentTime: TimeInterval = 0.0
    @Published public var isPlaying = false
    @Published public var progress: Float = 0.0
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    public func playSound(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
            startTimer()
            player?.play()
            isPlaying = true
        } catch {
            isPlaying = false
        }
    }
    
    public func stop() {
        player?.stop()
        stopTimer()
        isPlaying = false
    }
    
    public func pause() {
        player?.pause()
        stopTimer()
        isPlaying = false
    }
    
    public func resume() {
        player?.play()
        startTimer()
        isPlaying = true
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let player = self?.player else { return }
            self?.currentTime = player.currentTime
            self?.progress = Float(player.currentTime / player.duration)
            self?.objectWillChange.send()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    public func setTime(value: Float) {
        guard let player = player else { return }
        let newTime = TimeInterval(value) * player.duration
        player.currentTime = newTime
        currentTime = newTime
        if !player.isPlaying {
            player.play()
            isPlaying = true
        }
    }
}

struct ContentView: View {
    @State private var currentSongIndex = 0
    @State private var showSavedMessage = false
    @State private var showSendMessage = false
    @ObservedObject var viewModel = PlayerViewModel()
    let songs = ["Saruma", "Marmelad", "Somebody"]
    let artists = ["Каспийский груз", "Miyagi", "Gotye"]
    
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea()
            VStack {
                Image(songs[currentSongIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .cornerRadius(15)
                    .padding(.bottom, 60)
                HStack {
                    Image(songs[currentSongIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(50)
                    
                    infoSong()
                    Spacer()
                    buttonTralling()
                }
                .padding(.bottom)
                
                HStack {
                    Slider(value: $viewModel.progress, in: 0...1, onEditingChanged: { editing in
                        if !editing {
                            viewModel.setTime(value: viewModel.progress)
                        }
                    })
                    .accentColor(Color.white)
                    .padding(.trailing)
                    
                    Spacer()
                    
                    Text("\(formatTime(interval: Double(viewModel.currentTime)))")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                
                HStack(spacing: 50) {
                    Button(action: {
                        currentSongIndex = (currentSongIndex - 1 + songs.count) % songs.count
                        viewModel.playSound(name: songs[currentSongIndex])
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color("backgroundColor"))
                    
                    Button(action: {
                        if viewModel.isPlaying {
                            viewModel.pause()
                        } else {
                            viewModel.resume()
                        }
                    }) {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(Color("backgroundColor"))
                    }
                    .frame(width: 70, height: 70)
                    .background(Color.white)
                    .cornerRadius(100)
                    
                    Button(action: {
                        currentSongIndex = (currentSongIndex + 1) % songs.count
                        viewModel.playSound(name: songs[currentSongIndex])
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color("backgroundColor"))
                    .cornerRadius(15)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func formatTime(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let minutes = interval / 60
        let seconds = interval % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func infoSong() -> some View {
        return VStack(alignment: .leading) {
            Text(artists[currentSongIndex])
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                               
            Text(songs[currentSongIndex])
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
    
    func buttonTralling() -> some View {
        return HStack {
            Button(action: {
                showSavedMessage = true
            }) {
                Image("save")
                    .font(.title)
                    .foregroundColor(.white)
            }.actionSheet(isPresented: $showSavedMessage) {
                ActionSheet(
                    title: Text("Сохранение"),
                    message: Text("\(songs[currentSongIndex]) сохранен в папку загрузки"),
                    buttons: [.cancel()]
                )
            }
            Button(action: {
                showSendMessage = true
            }) {
                Image("send")
                    .font(.title)
                    .foregroundColor(.white)
            }.alert(isPresented: $showSendMessage) {
                Alert(
                    title: Text("Поделиться?"),
                    primaryButton: .default(Text("Да")),
                    secondaryButton: .cancel(Text("Нет"))
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
