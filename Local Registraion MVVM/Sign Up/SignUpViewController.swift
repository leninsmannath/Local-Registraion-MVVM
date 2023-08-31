//
//  SignUpViewController.swift
//  Local Registraion MVVM
//
//  Created by Lenin S on 30/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genderButton: UIButton!
    private var viewModel:SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupDelegates()
    }
    
    func setupViewModel () {
        self.viewModel = SignUpViewModel(withDelegate: self)
    }
    
    func setupDelegates () {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mobileTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func didTapSigUpButton(_ sender: Any) {
        viewModel.signUp(firstName: firstNameTextField.text, lastName: lastNameTextField.text, gender: genderButton.currentTitle, mobile: mobileTextField.text, email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapGender(_ sender: UIButton) {
        debugPrint("Gender menu action")
    }
    
}

//MARK:- SignUpViewModelProtocol
extension SignUpViewController:SignUpViewModelProtocol{
    func userRegisteredSuccessfully() {
        popupAlert(title: "Success", message: "User registered successfully", actionTitles: ["Okay"], actions: [.none])
    }
    
    func failedToRegister(withErrorMessage errorMessage: String) {
        popupAlert(title: "Failed", message: errorMessage, actionTitles: ["Okay"], actions: [.none])
    }
}
//MARK: - Text Field Delegate Methods
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        mobileTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
