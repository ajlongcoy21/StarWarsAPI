//
//  PeopleViewController.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/24/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController
{
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var bornDateLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    
    var people: [Person]?
    {
        didSet
        {
            personNameLabel.text = people![0].name
            bornDateLabel.text = people![0].born
            homeLabel.text = people![0].planet
            heightLabel.text = people![0].height
            eyeColorLabel.text = people![0].eye_color
            hairColorLabel.text = people![0].hair_color
            
            
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        
    }
}
