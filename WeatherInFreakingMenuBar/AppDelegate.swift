//
//  AppDelegate.swift
//  WeatherInFreakingMenuBar
//
//  Created by David Sere on 11/07/16.
//  Copyright © 2016 d53dev.net All rights reserved.
//

import Cocoa
import SwiftyBeaver

let log = SwiftyBeaver.self

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var menu: NSMenu!
    
    @IBAction func quitButtonTapped(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let path = NSBundle.mainBundle().pathForResource("credentials", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)!
        
        let swiftybeaverAppId = dict["swiftybeaverAppId"] as! String
        let swiftybeaverAppSecret = dict["swiftybeaverAppSecret"] as! String
        let swiftybeaverAppEncryptionKey = dict["swiftybeaverAppEncryptionKey"] as! String
        
        let platform = SBPlatformDestination(appID: swiftybeaverAppId, appSecret: swiftybeaverAppSecret, encryptionKey: swiftybeaverAppEncryptionKey)
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        
        log.addDestination(platform)
        log.addDestination(console)
        log.addDestination(file)
        
        log.info("Application started.")
        
        let p = ForecastIOProvider(apiKey: "1234")
        p.getCurrentWeatherForLocation(12.0, lon: 12.0){ (weather) in
            log.debug("Temp on date \(weather?.date) is \(weather?.temperature)")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        log.info("Application terminating.")
    }


}

