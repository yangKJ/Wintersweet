//
//  GIFViewController.swift
//  DepthDemo
//
//  Created by Condy on 2023/1/5.
//

import Foundation
import ImageX

class AnimatedView: UIView, AsAnimatable {
    
}

class GIFViewController: UIViewController {
    
    lazy var animatedView: AnimatedView = {
        let view = AnimatedView.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.contentsGravity = .resizeAspect
        view.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        return view
    }()
    
    lazy var placeholder: UILabel = {
        let label = UILabel()
        label.text = "Condy"
        label.backgroundColor = .cyan
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    lazy var animatedButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var richLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "test GIFs"
        setupUI()
        setupGIF()
        setupButton()
        setupRichLabel()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(animatedView)
        view.addSubview(animatedButton)
        view.addSubview(richLabel)
        NSLayoutConstraint.activate([
            animatedView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            animatedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animatedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            animatedView.heightAnchor.constraint(equalTo: animatedView.widthAnchor, multiplier: 1),
            animatedButton.topAnchor.constraint(equalTo: animatedView.bottomAnchor, constant: 20),
            animatedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animatedButton.widthAnchor.constraint(equalToConstant: 150),
            animatedButton.heightAnchor.constraint(equalToConstant: 150),
            richLabel.topAnchor.constraint(equalTo: animatedButton.bottomAnchor, constant: 20),
            richLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            richLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            richLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupGIF() {
        let filters: [C7FilterProtocol] = [
            C7WhiteBalance(temperature: 5555),
            C7Storyboard(ranks: 3)
        ]
        let data = R.gifData("pikachu")
        var options = AnimatedOptions()
        options.loop = .forever
        options.placeholder = .view(placeholder)
        animatedView.play(data: data, filters: filters, options: options)
    }
    
    func setupButton() {
        var options = AnimatedOptions()
        options.loop = .count(8)
        options.placeholder = .color(.red)
        options.contentMode = .scaleAspectFit
        options.bufferCount = 20
        options.cacheOption = .disk
        options.cacheCrypto = .sha1
        options.cacheDataZip = .gzip
        options.retry = DelayRetry(maxRetryCount: 2, retryInterval: .accumulated(2))
        options.setPreparationBlock(block: { _ in
            print("do something..")
        })
        options.setAnimatedBlock(block: { [weak self] _ in
            print("Played end!!!\(self?.animatedButton.image(for: .normal) ?? UIImage())")
        })
        let named = "https://blog.ibireme.com/wp-content/uploads/2015/11/bench_gif_demo.gif"
        animatedButton.mt.setImage(with: named, for: .normal, options: options)
    }
    
    func setupRichLabel() {
        
    }
    
    deinit {
        print("GIFViewController is deinit.")
    }
}
