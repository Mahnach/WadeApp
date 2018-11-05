//
//  SpendViewController.swift
//  phuza
//
//  Created by Sorochinskiy Dmitriy on 04.11.2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

class SpendViewController: UIViewController {
    
    enum SubmitButtonState: String {
        case submit = "Submit"
        case submitted = "Submitted"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var submitButtonState: SubmitButtonState = .submit
    var offer: Offer!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = offer.title
        subtitleLabel.text = "How much are you going to spend at \(offer.title) in the next 30 days?"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func submitButtonTouched(_ sender: Any) {
        if submitButtonState == .submit {
            submitButton.titleLabel?.text = SubmitButtonState.submitted.rawValue
            submitButtonState = .submitted
        }
    }
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
