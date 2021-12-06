//
//  SnowGlobe.swift
//  SnowGlobe
//

import UIKit

final class SnowGlobe {

    private weak var containingView: UIViewController?
    private let duration: TimeInterval
    private var animating: Bool = false
    private var particleLayer: CALayer?
    private var timer: Timer?

    init(containingView: UIViewController, duration: TimeInterval) {

        self.containingView = containingView
        self.duration = duration
    }

    func animate() {

        if animating {
            stop()
        } else {
            start()
        }
    }

    func start() {

        if let containingView = containingView,
        animating == false {

            self.timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
                self.stop()
            }

            animating = true
            createParticles(view: containingView.view)
        }
    }

    func stop() {

        guard animating == true else { return }
        animating = false
        timer?.invalidate()
        self.particleLayer?.removeFromSuperlayer()
    }
}

extension SnowGlobe {

    func createParticles(view: UIView) {

        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)

        let emitterCell = makeEmitterCell()
        particleEmitter.emitterCells = [emitterCell]

        view.layer.addSublayer(particleEmitter)

        particleLayer = particleEmitter
    }

    func makeEmitterCell() -> CAEmitterCell {

        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 20.0
        cell.lifetimeRange = 0
        cell.velocity = 60
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        cell.contents = UIImage(named: "{ADD SNOWFLAKE IMAGE NAME HERE}")?.cgImage

        return cell
    }

}
