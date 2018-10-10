//
//  ViewController.swift
//  Contactsss
//
//  Created by AFFIXUS IMAC1 on 8/1/18.
//  Copyright © 2018 AFFIXUS IMAC1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "App Name"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btContacts(_ sender: Any) {
        let vc: ContactListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactList") as! ContactListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

