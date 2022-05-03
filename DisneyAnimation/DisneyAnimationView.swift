//
//  DisneyAnimationView.swift
//  DisneyAnimation
//
//  Created by Juan vasquez on 02-05-22.
//

import Foundation
import UIKit
import QuartzCore

final class DisneyAnimationView: UIView {

    enum Constants {
        static let logoHeight: CGFloat = 150
        static let logoWidth: CGFloat = 120

        static let plusHeight: CGFloat = 30
        static let plusWidth: CGFloat = 30

        static let rainbowStart: CGFloat = 0.45
        static let rainbowEnd: CGFloat = 0.95

        static let backgroundImageHeight: CGFloat = 200
        static let backgroundImageMargin: CGFloat = 40

        static let rainbowAnimationDuration: CGFloat = 2
    }

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let backgroundImageView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disneyCastle2")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()

    private let disneyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disney")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let rainbowGradientLayer = CAGradientLayer()
    private let rainbowCircleLayer = CAShapeLayer()
    private let rainbowGlowLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(theme: Theme) {
        contentView.backgroundColor = theme.backgroundColor
        setupRainbow(colors: theme.rainbowColor)
        launchAnimations()
    }

    private func launchAnimations() {
        animateRainbow()
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.rainbowAnimationDuration) {
            self.animateCastle()
        }
    }

    private func setupView() {
        addSubview(contentView)
        addSubview(backgroundView)
        backgroundView.addSubview(backgroundImageView)
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(disneyImageView)
        containerStackView.addArrangedSubview(plusImageView)
    }

    private func setupRainbow(colors: [UIColor]) {
        layoutIfNeeded()
        let centerPoint = CGPoint(
            x: containerStackView.frame.size.width / 1.9,
            y: containerStackView.frame.size.height / 2
        )
        let radius = containerStackView.frame.size.width / 2.6
        let circlePath = UIBezierPath(
            arcCenter: centerPoint,
            radius: CGFloat(radius),
            startAngle: CGFloat(0),
            endAngle: 2 * .pi,
            clockwise: true
        )

        rainbowCircleLayer.path = circlePath.cgPath
        rainbowCircleLayer.fillColor = UIColor.clear.cgColor
        rainbowCircleLayer.strokeColor = UIColor.black.cgColor
        rainbowCircleLayer.lineWidth = 5
        rainbowCircleLayer.lineCap = .round
        rainbowCircleLayer.lineJoin = .round
        rainbowCircleLayer.strokeStart = Constants.rainbowStart
        rainbowCircleLayer.strokeEnd = Constants.rainbowEnd

        rainbowGradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        rainbowGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        rainbowGradientLayer.colors = colors.map { $0.cgColor }
        rainbowGradientLayer.frame = containerStackView.bounds
        rainbowGradientLayer.mask = rainbowCircleLayer
        containerStackView.layer.insertSublayer(rainbowGradientLayer, at: 0)
    }

    func animateCastle() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.backgroundImageView.alpha = 1
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.showFireworks()
        }
    }

    private func showFireworks() {
        let particleEmitter = CAEmitterLayer()
        particleEmitter.emitterPosition = CGPoint(x: bounds.width / 2, y: 200)
        particleEmitter.emitterSize = CGSize(width: bounds.size.width * 0.50, height: 1.0)
        particleEmitter.renderMode = .additive

        let rocket = makeEmiterCellRocket()
        let flare = makeEmiterCellFlare()
        let firework = makeEmiterCellFirework()
        let sparkle = makeSparkle()
        let prespark = makeEmitterCellPrespark(firework:firework)
        prespark.emitterCells = [sparkle]
        rocket.emitterCells = [flare, firework, prespark]
        particleEmitter.emitterCells = [rocket]
        layer.addSublayer(particleEmitter)
    }

    private func animateRainbow() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.timingFunction = .init(name: .easeInEaseOut)
        strokeAnimation.fromValue = Constants.rainbowStart
        strokeAnimation.toValue = Constants.rainbowEnd
        strokeAnimation.duration = Constants.rainbowAnimationDuration

        let scalePlusDuration = 0.5
        let scalePlusBegin = Constants.rainbowAnimationDuration - scalePlusDuration
        let scalePlusAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scalePlusAnimation.values = [0, 1, 1.5, 1]
        scalePlusAnimation.fillMode = .backwards
        scalePlusAnimation.beginTime = CACurrentMediaTime() + scalePlusBegin
        scalePlusAnimation.duration = scalePlusDuration

        rainbowCircleLayer.add(strokeAnimation, forKey: "startAnimation")
        plusImageView.layer.add(scalePlusAnimation, forKey: "scaleAnimation")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),

            backgroundImageView.topAnchor.constraint(equalTo: backgroundView.layoutMarginsGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Constants.backgroundImageMargin),
            backgroundImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Constants.backgroundImageMargin),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.backgroundImageHeight),

            contentView.trailingAnchor.constraint(greaterThanOrEqualTo: containerStackView.trailingAnchor),
            containerStackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            containerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: containerStackView.bottomAnchor),
            containerStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),

            disneyImageView.heightAnchor.constraint(equalToConstant: Constants.logoHeight),
            disneyImageView.widthAnchor.constraint(equalToConstant: Constants.logoWidth),
            plusImageView.widthAnchor.constraint(equalToConstant: Constants.plusWidth)
        ])
    }
}
