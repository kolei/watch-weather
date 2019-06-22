//
//  DetailInterfaceController.swift
//  
//
//  Created by WSR on 6/22/19.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet weak var tempMin: WKInterfaceLabel!
    @IBOutlet weak var tempMax: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        tempMax.setText(UserDefaults.standard.string(forKey: "maxTemp")!+" °C")
        
        tempMin.setText(UserDefaults.standard.string(forKey: "minTemp")!+" °C")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
