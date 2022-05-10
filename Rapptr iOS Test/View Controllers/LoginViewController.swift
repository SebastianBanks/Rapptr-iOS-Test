//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            createAlert(title: "Error", message: "Email textfield cannot be empty", didLogin: false)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            createAlert(title: "Error", message: "Password textfield cannot be empty", didLogin: false)
            return
        }
        
        let time = Date()
        
        LoginClient.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let message = "\(response.message)\nAPI call took \(self.getMilliseconds(from: time)) milliseconds"
                    self.createAlert(title: response.code, message: message, didLogin: true)
                case .failure(let error):
                    self.createAlert(title: "Error", message: "\(error.localizedDescription)", didLogin: false)
                }
            }
        }
        
        
    }
    
    func setupLayout() {
        let backgroundImage = UIImage(named: "img_login")
        
        if backgroundImage != nil {
            self.view.layer.contents = backgroundImage?.cgImage
        } else {
            self.view.backgroundColor = .viewBackground
        }
        
        emailTextField.layer.opacity = 0.6
        passwordTextField.layer.opacity = 0.6
    }
    
    func createAlert(title: String, message: String, didLogin: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if didLogin {
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
        } else {
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        }

        present(alert, animated: true)
    }
    
    func getMilliseconds(from time: Date) -> Int {
        let timePassed = Date().timeIntervalSince(time)
        let milli = Int((timePassed * 1000).truncatingRemainder(dividingBy: 1000))
        return milli
    }
}
