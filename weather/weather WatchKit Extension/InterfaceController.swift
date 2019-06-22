//
//  InterfaceController.swift
//  weather WatchKit Extension
//
//  Created by WSR on 6/22/19.
//  Copyright © 2019 WSR. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var lblTemperature: WKInterfaceLabel!
    @IBOutlet weak var imageICO: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        getWeather()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func getWeather(){
        // токен для АПИ
        let token = "1e936ee21707e2a418e98dca00877357"
        let city = "Moscow"
        
        // УРЛ с городом, метрической системой и токеном
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(token)"
        
        // перекодируем адрес (URLencode)
        let url = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // посылаем запрос
        Alamofire.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                //если запрос выполнен успешно, то разбираем ответ и вытаскиваем нужные данные
                let json = JSON(value)
                self.lblTemperature.setText(json["main"]["temp"].stringValue+" °C")
                
                //print(json)
                
                UserDefaults.standard.set(json["main"]["temp_min"].stringValue, forKey: "minTemp")
                
                UserDefaults.standard.set(json["main"]["temp_max"].stringValue, forKey: "maxTemp")
                
                //можно сразу запросить иконку (только нужно хранить название предыдущей, чтобы не запрашивать постоянно)
                let icoName = json["weather"][0]["icon"].stringValue
                
                if let urlStr2 = URL(string: "https://openweathermap.org/img/w/\(icoName).png") {
                    if let data = try? Data(contentsOf: urlStr2){
                        self.imageICO.setImage( UIImage(data: data) )
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
