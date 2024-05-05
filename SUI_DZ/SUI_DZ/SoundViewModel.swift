//
//  SoundViewModel.swift
//  SUI_DZ
//
import AVFoundation

/// Вью модель представления для управления воспроизведением аудио
class PlayerViewModel: ObservableObject {
    @Published public var maxDuration: TimeInterval = 0.0
    @Published public var currentTime: TimeInterval = 0.0
    @Published public var isPlaying = false
    @Published public var progress: Float = 0.0
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    /// Начать воспроизведение аудио
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
    
    /// Остановить воспроизведение
    public func stop() {
        player?.stop()
        stopTimer()
        isPlaying = false
    }
    
    /// Приостановить воспроизведение
    public func pause() {
        player?.pause()
        stopTimer()
        isPlaying = false
    }
    
    /// Возобновить воспроизведение
    public func resume() {
        player?.play()
        startTimer()
        isPlaying = true
    }
    
    /// Начать таймер для обновления текущего времени и прогресса воспроизведения
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let player = self?.player else { return }
            self?.currentTime = player.currentTime
            self?.progress = Float(player.currentTime / player.duration)
            self?.objectWillChange.send()
        }
    }
    
    /// Остановить таймер
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// Установить текущее время воспроизведения
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
