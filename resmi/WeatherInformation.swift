//
//  WeatherInformation.swift
//  resmi
//
//  Created by Admin on 26.09.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class WeatherInformation: UIViewController, UITableViewDelegate , UITableViewDataSource, WeatherGetterDelegate{
    
    @IBOutlet weak var refreshTable: UITableView!
    var refreshControl = UIRefreshControl()
    var data: [String] = []
    var weather: WeatherGetter!
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshTable.dataSource = self
        refreshTable.delegate = self

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshTable.addSubview(refreshControl)
        
        self.refreshTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        weather = WeatherGetter(delegate: self)
        
        weather.getWeather(city: cityName)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    @objc func refresh(_ sender: Any) {
        weather.getWeather(city: cityName)
    }
    
    /*@objc func backAction(){
        dismiss(animated: true, completion: nil)
    }*/
    
    func didGetWeather(weather: CurrentLocalWeather) {
        data.removeAll()
        data.append("Температура: " + String(weather.main.temp) + " °F")
        data.append("Погода: " + weather.weather[0].main)
        data.append("Скорость ветра: " + String(weather.wind.speed))
        self.refreshTable.reloadData()
        self.refreshControl.endRefreshing()
    }
}
