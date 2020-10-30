//
//  AppDelegate.swift
//  NumberStories
//
//  Created by Rankovic, Marko on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(1)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("AVAudioSessionCategoryPlayback not work")
        }
        return true
    }
    
}
