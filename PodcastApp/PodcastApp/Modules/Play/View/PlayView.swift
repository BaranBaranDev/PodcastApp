//
//  PlayView.swift
//  PodcastApp
//
//  Created by Baran Baran on 11.06.2024.
//

import UIKit
import SnapKit
import AVFoundation

final class PlayView: UIView {
    
    
    // MARK: - Properties
    
    private var episodeModel: EpisodeResponse?
    private var player: AVPlayer?
    
    public var closeAction: (() -> Void)?
    
    // MARK: - UI Elements
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return btn
    }()
    
    private lazy var episodeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private lazy var slider: UISlider = {
        let sld = UISlider()
        sld.setThumbImage(UIImage(), for: .normal)
        return sld
    }()
    
    private lazy var startLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var endLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        return lbl
    }()
    
    private lazy var podcastName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Podcast Name"
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var goForward: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "goforward.5"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.addTarget(self, action: #selector(handleGoForWardButton), for: .touchUpInside)
        return btn
    }()
    
    private lazy var goPlayOrPause: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        return btn
    }()
    
    private lazy var goBackward: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "gobackward.5"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.addTarget(self, action: #selector(handleGoBackWardButton), for: .touchUpInside)
        return btn
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startLabel, endLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var playStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),goBackward, goPlayOrPause, goForward,UIView()])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var fullStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [closeButton, episodeImage, slider, labelStackView, podcastName, playStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Initialization
    

    
    
    init(frame: CGRect, episodeModel: EpisodeResponse) {
        self.episodeModel = episodeModel
        super.init(frame: frame)
        setup()
        layout()
        configure()
        startPlay()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup & Layout
    
    private func setup() {
        // background
        backgroundColor = .systemBackground
        
        // subviews
        addSubview(fullStackView)
    }
    
    private func layout() {
        // layout
        fullStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        // size constraints
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
        
        episodeImage.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        slider.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
        
        goPlayOrPause.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        goForward.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        goBackward.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        // content hugging priority
        goBackward.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        goPlayOrPause.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        goForward.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}


// MARK: - setupPlayer & Actions

fileprivate extension PlayView {
    
    func startPlay(){
        guard let episode = episodeModel else { return }
        guard let url = URL(string: episode.streamUrl) else { return }
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // Periodik zaman gözlemcisi ekleme
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            self.updateTime()
            self.updateSlider()
        }
        
        player?.play()
    }
    
    
    
    func updateSlider(){
        guard let player = player  else { return }
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self.slider.value = Float(resultSecondTime)
    }
    
    func updateTime() {
        guard let player = player, let currentItem = player.currentItem else { return }
        
        let currentTime = currentItem.currentTime()
        let duration = currentItem.duration
        
        let currentTimeSeconds = CMTimeGetSeconds(currentTime)
        let durationSeconds = CMTimeGetSeconds(duration)
        
        let currentFormatted = formatTime(currentTimeSeconds)
        let durationFormatted = formatTime(durationSeconds - currentTimeSeconds) // Kalan süreyi hesapla
        
        startLabel.text = currentFormatted
        endLabel.text = durationFormatted
    }
    
    
    func formatTime(_ seconds: Double) -> String {
        // Kontrol etmek için sınırsız veya NaN (sayı olmayan) değerler
        if seconds.isInfinite || seconds.isNaN {
            return "00:00"
        }
        
        // Diğer durumlar için zamanı biçimlendir
        let totalSeconds = Int(seconds)
        let mins = totalSeconds / 60
        let secs = totalSeconds % 60
        
        // Zamanı biçimlendirerek geri döndür
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func updateForward(value: Int64){
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd((player?.currentTime())!, exampleTime)
        player?.seek(to: seekTime)
    }
    
    
    @objc func handleClose() {
        closeAction!()
    }
    
    @objc func handlePlay() {
        guard let player = player else { return }
        if player.timeControlStatus == .paused {
            player.play()
            goPlayOrPause.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        } else {
            player.pause()
            goPlayOrPause.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }
    }
    
    @objc func handleGoBackWardButton(_ sender: UIButton){
        updateForward(value: -5)
    }
    @objc func handleGoForWardButton(_ sender: UIButton){
        updateForward(value: 5)
    }
}
    // MARK: - Configure
    
private extension PlayView {
        func configure() {
            guard let episode = episodeModel else { return }
            episodeImage.downloadImage(with: episode.imageUrl)
            podcastName.text = episode.title
            
        }
        
}
    
    
