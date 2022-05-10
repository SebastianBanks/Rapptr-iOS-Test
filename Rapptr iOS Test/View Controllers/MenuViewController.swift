//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coding Tasks"
        setupLayout()
    }
    
    // MARK: - Actions
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
    
    
    func setupNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            
            navBarAppearance.backgroundColor = .appBlue
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17, weight: .bold)]
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = .appBlue
        }
        
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64.0)
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
    }
        
    func setupLayout() {
        
        setupNavBar()
        
        let backgroundImage = UIImage(named: "bg_home_menu")
        
        if backgroundImage != nil {
            self.view.layer.contents = backgroundImage?.cgImage
        } else {
            self.view.backgroundColor = .viewBackground
        }
        
        let buttonFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        chatButton.titleLabel?.font = buttonFont
        loginButton.titleLabel?.font = buttonFont
        animationButton.titleLabel?.font = buttonFont
        
        chatButton.titleLabel?.textAlignment = .left
        loginButton.titleLabel?.textAlignment = .left
        animationButton.titleLabel?.textAlignment = .left
        
        let chatImage = UIImage(named: "ic_chat")
        let loginImage = UIImage(named: "ic_login")
        let animationImage = UIImage(named: "ic_animation")
        
        chatButton.tintColor = .black
        loginButton.tintColor = .black
        animationButton.tintColor = .black
        
        chatButton.setImage(chatImage, for: .normal)
        loginButton.setImage(loginImage, for: .normal)
        animationButton.setImage(animationImage, for: .normal)
        
        chatButton.contentHorizontalAlignment = .left
        loginButton.contentHorizontalAlignment = .left
        animationButton.contentHorizontalAlignment = .left
        
        chatButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        chatButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        loginButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        animationButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        animationButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        chatButton.backgroundColor = .viewBackground
        loginButton.backgroundColor = .viewBackground
        animationButton.backgroundColor = .viewBackground
        
        chatButton.layer.opacity = 0.8
        loginButton.layer.opacity = 0.8
        animationButton.layer.opacity = 0.8
        
        chatButton.layer.cornerRadius = 8
        loginButton.layer.cornerRadius = 8
        animationButton.layer.cornerRadius = 8
        
        chatButton.frame = CGRect(x: 0, y: 0, width: 315, height: 55)
        
        
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let buttonStackView = UIStackView(arrangedSubviews: [chatButton, loginButton, animationButton])
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 24
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 227),
            buttonStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -227),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
    }
}
