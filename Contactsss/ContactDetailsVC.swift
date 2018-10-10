//
//  ContactDetailsVC.swift
//  Contactsss
//
//  Created by AFFIXUS IMAC1 on 8/2/18.
//  Copyright © 2018 AFFIXUS IMAC1. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactDetailsVC: UIViewController {
    
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lbContactName: UILabel!
    @IBOutlet weak var lbContactName1: UILabel!
    @IBOutlet weak var lbContactEmail: UILabel!
    @IBOutlet weak var lbContactMobileNo: UILabel!
    
    var objectsList = CNContact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Contact Details"
        
        if let imageData = objectsList.imageData {
            let userImage = UIImage(data: imageData)
            imgContact.image = userImage;
        }else{
            imgContact.image = UIImage (named: "N.A")
        }
        
        let formatter = CNContactFormatter()
        lbContactName.text = formatter.string(from: objectsList)
        lbContactName1.text = "Name: " + formatter.string(from: objectsList)!
        
        if let actualEmail = (objectsList as AnyObject).emailAddresses?.first?.value as String? {
            lbContactEmail.text = "Email ID: " + actualEmail
        }else{
            lbContactEmail.text = "Email ID: N.A"
        }
        
        if let actualNumber = objectsList.phoneNumbers.first?.value as? CNPhoneNumber {
            lbContactMobileNo.text = "Mobile Number: " + actualNumber.stringValue
        }else{
            lbContactMobileNo.text = "Mobile Number: N.A"
        }
    }
    
    
    
}
