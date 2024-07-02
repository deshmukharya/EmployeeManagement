//
//  AddEmployeeViewController.swift
//  Employee
//
//  Created by E5000861 on 20/06/24.
//

import UIKit

class AddEmployeeViewController: UIViewController, UINavigationControllerDelegate {
    
    
    var imageView = UIImageView()
    let idTextField = UITextField()
    let nameTextField = UITextField()
    var emailTextField = UITextField()
    let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setBackgroundImage()
        setupUI()
    }
    
    func setBackgroundImage() {
            // Create UIImageView for background image
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "design")
            backgroundImage.contentMode = .scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0) // Insert at the back
    
        }
    func setupUI() {
        // ID Text Field
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 100// Half of the width/height to make it circular
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "undrawemployee")
       
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:80),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])

        idTextField.placeholder = "Enter ID"
        idTextField.borderStyle = .roundedRect
        view.addSubview(idTextField)
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 250),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            idTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Name Text Field
        nameTextField.placeholder = "Enter Name"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 25),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        emailTextField.placeholder = "Enter Email"
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Save Button
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = .white
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    
    @objc func onClick(_sender: Any){
        
        if !validateID() || !validateName() || !validateEmail() {
                    return
                }
        if let name = nameTextField.text, let id = idTextField.text , let email = emailTextField.text
        {
            let newEmployee = Employee(context: DBManager.shared.context)
            newEmployee.name = name
            newEmployee.id = id
            newEmployee.email = email
            DBManager.shared.saveContext()
        }
        clearFields()
    }
    
    func clearFields() {
        idTextField.text = ""
        nameTextField.text = ""
        emailTextField.text = ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func validateID() -> Bool {
        guard let id = idTextField.text, !id.isEmpty else {
            showAlert(message: "ID cannot be empty.")
            return false
        }
        guard let _ = Int(id) else {
            showAlert(message: "Please enter a numeric value for ID.")
            return false
        }
        if id.count > 5 {
            showAlert(message: "Id should contain less than 5 digits.")
            return false
        }
        
        return true
    }
    
    func validateName() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Name cannot be empty.")
            return false
        }
        let nameCharacterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
        if name.rangeOfCharacter(from: nameCharacterSet.inverted) != nil {
            showAlert(message: "Please enter a valid name (alphabetic characters only) .")
            return false
        }
        return true
    }
    func validateEmail() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Email cannot be empty.")
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if !emailPredicate.evaluate(with: email) {
            showAlert(message: "Please enter a valid email address.")
            return false
        }
        
        return true
    }

  
}
