//
//  UpdateViewController.swift
//  Employee
//
//  Created by E5000861 on 20/06/24.
//

import UIKit

protocol UpdateEmployeeDelegate: AnyObject {
    func didUpdateEmployee()
}

class UpdateViewController: UIViewController {
    
    var selectedEmployee: Employee?
    weak var delegate: UpdateEmployeeDelegate?
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let updateButton = UIButton()
    let updateNameLabel = UILabel()
    let updateEmailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupUI()
        setBackgroundImage()
        if let student = selectedEmployee {
            nameTextField.text = student.name
            emailTextField.text = student.email
        }
    }
    func setBackgroundImage() {
            // Create UIImageView for background image
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "design")
            backgroundImage.contentMode = .scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0) // Insert at the back
    
        }
    func setupUI() {
        
      
        // Name Text Field
        nameTextField.placeholder = "Enter Name"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 200),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Email Text Field
        emailTextField.placeholder = "Enter Email"
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 70),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Update Button
        updateButton.setTitle("Update", for: .normal)
        updateButton.setTitleColor(.black, for: .normal)
        updateButton.backgroundColor = .white
        updateButton.layer.cornerRadius = 5
        updateButton.addTarget(self, action: #selector(onUpdateClick), for: .touchUpInside)
        view.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 120),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 100),
            updateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
      
        updateNameLabel.text = "Update Name"
        updateNameLabel.textColor = .white
        updateNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        updateNameLabel.textAlignment = .left // Adjust alignment as needed
        updateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updateNameLabel)

        // Constraints for Update Name Label
        NSLayoutConstraint.activate([
            updateNameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -10),
            updateNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])

        // Update Email Label
        updateEmailLabel.text = "Update Email"
        updateEmailLabel.textColor = .white
        updateEmailLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        updateEmailLabel.textAlignment = .left // Adjust alignment as needed
        updateEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updateEmailLabel)

        // Constraints for Update Email Label
        NSLayoutConstraint.activate([
            updateEmailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -30),
            updateEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    func DispatchQueue(){
        
    }
    @objc func onUpdateClick(_ sender: Any) {
        
        if !validateEmail() {
            guard let employee = selectedEmployee,
                  let name = nameTextField.text, !name.isEmpty,
                  let email = emailTextField.text, !email.isEmpty else {
                showAlert(message: "All fields are required.")
                return
            }
            
            DBManager.shared.updateStudent(student: employee, name: name, email: email)
            
            delegate?.didUpdateEmployee()
            dismiss(animated: true, completion: nil)
        }
      }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
