//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Konstantin on 06.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let userName = "User"
    private let userPassword = "Password"

    @IBOutlet var scrolView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func scrollTapped(_ gesture: UIGestureRecognizer) {
        scrolView.endEditing(true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "weatherCell" {
            let isValid = checkUserData()
            if !isValid {
                showAlert(title: "Ошибка", message: "Не правильно указаны логин и пароль!")
            }
            return isValid
        }
        
        return false
    }

}

// MARK: - Setup Keyboard Notification

extension LoginViewController {
    
    private func setupKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        scrolView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrolView.contentInset = .zero
    }
    
    
    
}

// MARK: - Check Users

extension LoginViewController {
    
    private func checkUserData() -> Bool {
        return loginTextField.text == userName && passwordTextField.text == userPassword
    }
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alerAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alerAction)
        present(alert , animated: true, completion: nil)
    }
    
    
}
