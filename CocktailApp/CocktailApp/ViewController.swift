//
//  ViewController.swift
//  CocktailApp
//
//  Created by user238581 on 4/19/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func drinkBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "category_vc") as! CategoryViewController
                present(vc, animated: true)      }
    
}

