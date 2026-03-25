//
//  LoadingHUD.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 04/08/2018.
//  Updated by SOGApps on 03/24/2026.
//  Updated for Lottie v4.6.0
//

import UIKit
import Lottie

class LoadingHUD: UIView {

    // MARK: - Properties
    static let shared = LoadingHUD(frame: UIScreen.main.bounds)

    private var animation: LottieAnimationView?
    var animationFile: String = "Loader_YW"
    var bgColor: UIColor = .clear
    var applyBlur: Bool = true

    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isHidden = true
        setupUI()
    }

    private func setupUI() {
        backgroundColor = bgColor
    }

    // MARK: - Show HUD
    func show() {
        guard let keyWindow = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow }) else { return }

        showInView(view: keyWindow)
    }

    func showInView(view: UIView) {
        backgroundColor = bgColor

        if applyBlur {
            if blurView.superview == nil {
                insertSubview(blurView, at: 0)
                NSLayoutConstraint.activate([
                    blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    blurView.topAnchor.constraint(equalTo: topAnchor),
                    blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            }
        }

        // Remove previous animation if any
        animation?.removeFromSuperview()

        // Load animation
        let lottieAnimation = LottieAnimation.named(animationFile, bundle: Bundle.getResourcesBundle() ?? Bundle.main)
        animation = LottieAnimationView(animation: lottieAnimation)
        guard let animation = animation else { return }
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animation)

        NSLayoutConstraint.activate([
            animation.centerXAnchor.constraint(equalTo: centerXAnchor),
            animation.centerYAnchor.constraint(equalTo: centerYAnchor),
            animation.widthAnchor.constraint(equalToConstant: 80),
            animation.heightAnchor.constraint(equalToConstant: 80)
        ])

        animation.play()

        if superview == nil {
            view.addSubview(self)
        }
        isHidden = false
    }

    // MARK: - Hide HUD
    func hide() {
        animation?.stop()
        animation?.removeFromSuperview()
        isHidden = true
        removeFromSuperview()
    }
}
