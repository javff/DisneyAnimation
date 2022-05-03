//
//  DisneyAnimationViewController.swift
//  DisneyAnimation
//
//  Created by Juan vasquez on 02-05-22.
//

import UIKit

protocol DisneySplashControllerDelegate: AnyObject {
    func splashController(_ controller: DisneySplashScreenViewController, finished: Bool)
}

final class DisneySplashScreenViewController: UIViewController {

    private let theme: Theme
    private let animationView = DisneyAnimationView()
    private let duration: CGFloat

    weak var delegate: DisneySplashControllerDelegate?

    init(theme: Theme, duration: CGFloat) {
        self.theme = theme
        self.duration = duration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDuration()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        animationView.setup(theme: theme)
    }

    private func setupDuration() {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            guard let self = self else { return }
            self.delegate?.splashController(self, finished: true)
        }
    }
}
