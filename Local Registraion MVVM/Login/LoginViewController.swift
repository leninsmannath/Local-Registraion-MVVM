//
//  LoginViewController.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var viewModel:LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupDelegate()
        setupMockData()
        // Do any additional setup after loading the view.
    }
    func setupMockData () {
        emailTextField.text = "leninsmannath@gmail.com"
        passwordTextField.text = "12345"
    }
    func setupViewModel () {
        self.viewModel = LoginViewModel(withDelegate: self)
    }
    
    func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        self.viewModel.login(withEmail: self.emailTextField.text, andPassword: self.passwordTextField.text)
    }
    @IBAction func didTapSignUpButton(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- LoginViewModelProtocol
extension LoginViewController:LoginViewModelProtocol{
    func userLoggedInSuccessfully(user: User) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewConntroller") as? HomeViewConntroller {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func failedToLoggedIn(withErrorMessage errorMessage: String) {
        popupAlert(title: "Failed", message: errorMessage, actionTitles: ["Okay"], actions: [.none])
    }
}
//MARK: - Text Field Delegate Methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
