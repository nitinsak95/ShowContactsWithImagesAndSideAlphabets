//
//  ContactListVC.swift
//  Contactsss
//
//  Created by AFFIXUS IMAC1 on 8/1/18.
//  Copyright © 2018 AFFIXUS IMAC1. All rights reserved.
//

import UIKit
import Foundation
import Contacts
import ContactsUI
import MYTableViewIndex

class ContactListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var ContactListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let arrIndexSection = ["A","B","C","D", "E", "F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var objects  = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Contacts List"
        
        searchBar.delegate = self
        
        ContactListTableView.delegate = self
        ContactListTableView.dataSource = self
        
        self.getContacts()
        
    }
    
    func getContacts() {
        let store = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
            self.retrieveContactsWithStore(store: store)
            
        case .notDetermined:
            store.requestAccess(for: .contacts){succeeded, err in
                guard err == nil && succeeded else{
                    return
                }
                self.retrieveContactsWithStore(store: store)
                
            }
        default:
            print("Not handled")
        }
        
    }
    
    func retrieveContactsWithStore(store: CNContactStore) {
        
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey,CNContactImageDataKey, CNContactEmailAddressesKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        request.sortOrder = CNContactSortOrder.givenName
        var cnContacts = [CNContact]()
        do {
            try store.enumerateContacts(with: request){
                (contact, cursor) -> Void in
                if (!contact.phoneNumbers.isEmpty) {
                }
                
                if contact.isKeyAvailable(CNContactImageDataKey) {
                    if let contactImageData = contact.imageData {
                        print(UIImage(data: contactImageData)) // Print the image set on the contact
                    }
                } else {
                    // No Image available
                }
                if (!contact.emailAddresses.isEmpty) {
                }
                cnContacts.append(contact)
                self.objects = cnContacts
            }
        } catch let error {
            NSLog("Fetch contact error: \(error)")
        }
        
        NSLog(">>>> Contact list:")
        
        for contact in cnContacts {
            let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "No Name"
            NSLog("\(fullName): \(contact.phoneNumbers.description)")
        }
        
        self.ContactListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactDetailsCell
        cell.selectionStyle = .none
        
        let contact = self.objects[indexPath.row]
        print("theis my contact arrau \(self.objects.count)")
        let formatter = CNContactFormatter()
        cell.lbPersonName.text = formatter.string(from: contact)
        
        if let imageData = contact.imageData {
            let userImage = UIImage(data: imageData)
            cell.imgPerson.image = userImage;
        }else{
            cell.imgPerson.image = UIImage (named: "N.A")
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.objects[indexPath.row]
        let vc: ContactDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactDetails") as! ContactDetailsVC
        vc.objectsList = contact
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return arrIndexSection.count
//    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return arrIndexSection
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
    
}

