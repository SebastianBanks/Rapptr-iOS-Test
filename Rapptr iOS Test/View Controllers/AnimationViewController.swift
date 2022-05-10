//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var animationButton: UIButton!
    private var isFadeIn = false
    
    var animationView: AnimationView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        setupView()
        
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if isFadeIn {
            logoImage.fadeIn()
            animationButton.setTitle("FADE OUT", for: .normal)
        } else {
            logoImage.fadeOut()
            animationButton.setTitle("FADE IN", for: .normal)
        }
        isFadeIn.toggle()
        createLayer()
    }
    
    func setupView() {
        let tapGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(imageTapped))
        logoImage.isUserInteractionEnabled = true
        logoImage.addGestureRecognizer(tapGestureRecognizer)

        logoImage.frame = CGRect(x: self.view.frame.size.width/2 - logoImage.frame.size.width/2, y: 140, width: logoImage.frame.width, height: logoImage.frame.height)
    }

    func dragImageView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: logoImage)
        guard let gestureView = gesture.view else { return }

        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )

        gesture.setTranslation(.zero, in: logoImage)
    }

    @objc func imageTapped(_ gesture: UIPanGestureRecognizer) {
        dragImageView(gesture: gesture)
    }
    
    private func createLayer() {
        let layer = CAEmitterLayer()
        layer.emitterPosition = CGPoint(x: view.center.x, y: -100)
        
        let colors: [UIColor] = [
            .systemPink,
            .systemBlue,
            .systemGreen,
            .systemYellow,
            .systemPurple,
            .systemRed,
            .systemOrange
        ]
        
        let cells: [CAEmitterCell] = colors.compactMap {
            let cell = CAEmitterCell()
            cell.scale = 0.05
            cell.emissionRange = .pi * 2
            cell.lifetime = 10
            cell.birthRate = 50
            cell.velocity = 170
            cell.color = $0.cgColor
            cell.contents = UIImage(named: "confetti")!.cgImage
            return cell
        }
        
        animationView = .init(name: "firework")
        animationView?.frame = view.bounds
        animationView?.loopMode = .playOnce
        animationView?.layer.zPosition = -1
        view.addSubview(animationView!)
        animationView?.play()
        
        layer.emitterCells = cells
        
        view.layer.addSublayer(layer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            layer.removeFromSuperlayer()
            self.animationView?.removeFromSuperview()
        }
    }
}


