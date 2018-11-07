//
//  SpendViewController.swift
//  phuza
//
//  Created by Sorochinskiy Dmitriy on 04.11.2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FBSDKLoginKit

class SpendViewController: UIViewController {
    
    enum SubmitButtonState: String {
        case submit = "Submit"
        case submitted = "Submitted"
    }
    
    var ref: DatabaseReference!

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
        ref = Database.database().reference()
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
            submitButton.setTitle(SubmitButtonState.submitted.rawValue, for: .normal)
            submitButtonState = .submitted
            writeSpendData()
            submitButton.isEnabled = false
        }
    }
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func writeSpendData() {
        guard let user = DataManager.shared.currentUser else { return }
        
        let spendInfoRef = ref.child("spend_info")
        let key = spendInfoRef.childByAutoId().key
        let spendInfo: [String: Any] = [
            "id": key!,
            "display_name": String(user.displayName ?? ""),
            "brand_name": offer.title,
            "amount": Int(amountTextField.text ?? "0") ?? 0]
       
        spendInfoRef.child(key!).setValue(spendInfo)
    }
}
