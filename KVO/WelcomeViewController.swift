//
//  ViewController.swift
//  KVO
//
//  Created by Margiett Gil on 4/9/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    private var iconNameObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFontSizeObservation()
        configureIconNameObservation()
    }
    
    
    private func configureFontSizeObservation() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            guard let newSize = change.newValue else { return }
            // update UI
            let fontSize = CGFloat(newSize)
            self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    private func configureIconNameObservation() {
        iconNameObservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self ] (settings, change) in
            //update ui for image icon
            guard let iconName = change.newValue else { return }
            self?.iconImageView.image = UIImage(systemName: iconName)
            
        })
    }
    deinit { // this gets called when the object is not longer in memory
        // we want to invalidate because when we in the screen we dont want to keep running memeory
        // this is like a remover
        //you dont want to get calls from the settings view controller
        // if you no longer on screen you dont want any updates
        // will stop observing
        
        fontSizeObservation?.invalidate()
        iconNameObservation?.invalidate()
        
    }
    /*
     this is a stack
     viewcontroller3
     viewcontroller2
     viewcontroller1
     navigationController
     */
    

}

