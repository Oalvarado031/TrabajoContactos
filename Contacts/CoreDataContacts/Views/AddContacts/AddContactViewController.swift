//
//  AddNoteViewController.swift
//  CoreDataDemo
//
//  Created by Macbook on 28/9/24.
//

import UIKit

class AddContactViewController: UIViewController {
    
    private let controller: MainController

    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var addresTextField: UITextField!
    
    init(controller: MainController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Contact"
    }

    @IBAction func onTapAddNoteButton(_ sender: Any) {
        guard let nameText = noteTextField.text else { return }
        guard let numberText = numberTextField.text else { return }
        guard let number = Int16(numberText) else { return }
        guard let addressText = addresTextField.text else { return }
        
        
        controller.saveContact(name: nameText, number: number, address: addressText)
        
        navigationController?.popViewController(animated: true)
    }

}
