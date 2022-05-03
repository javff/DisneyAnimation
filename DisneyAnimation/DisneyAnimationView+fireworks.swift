//
//  DisneyAnimationView+fireworks.swift
//  DisneyAnimation
//
//  Created by Juan vasquez on 03-05-22.
//

import UIKit

extension DisneyAnimationView {
    func makeSparkle() -> CAEmitterCell {
        let cell = CAEmitterCell()
        let image = UIImage(named: "tspark")?.cgImage
        cell.contents = image
        cell.birthRate = 10
        cell.lifetime = 2
        cell.yAcceleration = 150
        cell.beginTime = 1
        cell.scale = 0.05
        return cell
    }

    func makeEmiterCellRocket() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.emissionLongitude = -.pi/4
        cell.emissionLatitude = 0
        cell.emissionRange = .pi/4
        cell.lifetime = 1.6
        cell.birthRate = 1

        cell.velocity = 50
        cell.velocityRange = cell.velocity/4
        cell.yAcceleration = -60

        let color = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        cell.color = color.cgColor
        cell.redRange = 0.5
        cell.greenRange = 0.5
        cell.blueRange = 0.5
        cell.name = "rocket"
        return cell
    }

    func makeEmiterCellFlare() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.color = UIColor.white.cgColor
        cell.contents = UIImage(named: "tspark")?.cgImage

        cell.emissionLongitude = (2 * .pi)
        cell.birthRate = 45
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.scale = 0.3

        cell.yAcceleration = 150

        cell.emissionRange = .pi/7
        cell.alphaSpeed = -0.7
        cell.scaleSpeed = -0.1
        cell.scaleRange = 0.1
        cell.beginTime = 0.01

        cell.duration = 2.0
        cell.name = "flare"
        return cell
    }

    func makeEmiterCellFirework() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "tspark")?.cgImage
        cell.birthRate = 8000
        cell.velocity = 130
        cell.lifetime = 1.0
        cell.emissionRange = (2 * .pi)
        /* determines size of explosion */
        cell.scale = 0.1
        cell.alphaSpeed = -0.2
        cell.yAcceleration = 80
        cell.beginTime = 1.5
        cell.duration = 0.1
        cell.scaleSpeed = -0.015
        cell.spin = 2
        cell.name = "firework"
        return cell
    }


    func makeEmitterCellPrespark(firework:CAEmitterCell) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 80
        cell.velocity = firework.velocity * 0.70
        cell.lifetime = 1.2
        cell.yAcceleration = firework.yAcceleration * 0.85
        cell.beginTime = firework.beginTime - 0.2
        cell.emissionRange = firework.emissionRange
        cell.greenSpeed = 100
        cell.blueSpeed = 100
        cell.redSpeed = 100
        cell.name = "preSpark"
        return cell
    }

    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05

        cell.contents = UIImage(named: "tspark")?.cgImage
        return cell
    }
}
