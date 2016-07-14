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
        setupLocalLogger()
        
        if let path = NSBundle.mainBundle().pathForResource("credentials", ofType: "plist"), credentials = NSDictionary(contentsOfFile: path) as? [String: String] {
            if let swiftybeaverAppId = credentials["swiftybeaverAppId"],
                swiftybeaverAppSecret = credentials["swiftybeaverAppSecret"],
                swiftybeaverAppEncryptionKey = credentials["swiftybeaverAppEncryptionKey"] {
                setupRemoteLogger(swiftybeaverAppId, appSecret: swiftybeaverAppSecret, encryptionKey: swiftybeaverAppEncryptionKey)
            } else {
                log.error("Could not load swifty beaver credentials from credentials file, there will be no logging to SwiftyBeaver cloud.")
            }
        } else {
            log.error("Could not load credentials file, there will be no logging to SwiftyBeaver Cloud")
        }
        
        log.info("Application started.")
        
        
        // TODO: move this info to preference window
        let defaults = NSUserDefaults.standardUserDefaults()
        if let forecastIOApiKey = defaults.stringForKey("forecastIOApiKey") {
            let p = ForecastIOProvider(apiKey: forecastIOApiKey)
            
            p.getCurrentWeatherForLocation(12.0, lon: 12.0){ (weather) in
                log.debug("Temp on date \(weather?.date) is \(weather?.temperature)")
            }
        }
    }
    
    func loadCredentials() -> [String: String]?{
        if let path = NSBundle.mainBundle().pathForResource("credentials", ofType: "plist"), credentials = NSDictionary(contentsOfFile: path) as? [String: String] {
            return credentials
        } else {
            return nil
        }
    }
    
    func setupLocalLogger(){
        let console = ConsoleDestination()  // log to Xcode Console
        let file = FileDestination()  // log to default swiftybeaver.log file
        
        log.addDestination(console)
        log.addDestination(file)
    }
    
    func setupRemoteLogger(appId: String, appSecret: String, encryptionKey: String){
        let platform = SBPlatformDestination(appID: appId, appSecret: appSecret, encryptionKey: encryptionKey)
        
        log.addDestination(platform)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        log.info("Application terminating.")
    }


}

