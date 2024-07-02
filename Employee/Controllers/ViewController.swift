//
//  ViewController.swift
//  Employee
//
//  Created by E5000861 on 12/06/24.
//

//Employee List - Employee list and + button on top to add new employee
//Fetch all employees
//Show in a list (Table view) -> Emp Name & Emp mail id
//2. Create Employee Screen
//Em Name - Txt Fld
//Emp mail id - Txt Fls
//Update Employee Screen
//Pre filled Em Name - Txt Fld


import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UpdateEmployeeDelegate {
  
    
    
    @IBOutlet weak var studentTable: UITableView!
    
    var employee = [Employee]()
    override func viewDidLoad() {
        super.viewDidLoad()
        studentTable.reloadData()
        studentTable.delegate = self
        studentTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employee = DBManager.shared.fetchData()
        studentTable.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let employeeData = employee[indexPath.row]
        cell.textLabel?.text = employeeData.name
        cell.detailTextLabel?.text = employeeData.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            do{
                try DBManager.shared.context.delete(employee[indexPath.row])
            }catch{print("Error")}
            DBManager.shared.saveContext()
            employee.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*init alert controller with title, message & .alert style*/
        let selectedEmployee = employee[indexPath.row]
               let updateEmployeeVC = UpdateViewController()
               updateEmployeeVC.selectedEmployee = selectedEmployee
               updateEmployeeVC.delegate = self
               navigationController?.pushViewController(updateEmployeeVC, animated: true)
        
    }
    
    func didUpdateEmployee() {
        employee = DBManager.shared.fetchData()
        studentTable.reloadData()
    }
}
