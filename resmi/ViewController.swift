//
//  ViewController.swift
//  resmi
//
//  Created by Admin on 26.09.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    let cities = ["Almaty", "London"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         performSegue(withIdentifier: "SegueToFirstVC", sender: cities[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToFirstVC" {
            var vc = segue.destination as! WeatherInformation
            vc.cityName = sender as! String
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame.size.height = 300
        tableView.dataSource = self
        tableView.delegate = self
    }

    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }

}

