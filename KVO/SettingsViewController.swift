//
//  SettingsViewController.swift
//  KVO
//
//  Created by Margiett Gil on 4/9/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var fontSlider: UISlider! // will not be using this
    @IBOutlet weak var fontsizeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var fontSizeObservation: NSKeyValueObservation?
    
    
    // data for the pickerview
    private let iconNames = ["sun.haze.fill", "moon", "globe", "icloud"] // SFSymbol s image name example "moon"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirgurePickerView()
        configureFontSizeObservation()
    }
    
    private func confirgurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func configureFontSizeObservation() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
            guard let newSize = change.newValue else { return }
            self? .fontsizeLabel.text = newSize.description
        })
    }
    
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let newSize = Int(sender.value) // cast Float to Int as our settings fontSize is an Int
        Settings.shared.fontSize = newSize
        // after setting the iconName on the Settings Class
               // the welcomeViewController will be updated via KVO
               // observation 
        
    }
} // curly for the class


extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // this are the number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  iconNames.count // number of rows
    }
    
    
}
extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iconNames[row] // if it was a table view it would have been a indexpath.row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let iconName = iconNames[row]
        Settings.shared.iconName = iconName
        // after setting the iconName on the Settings Class
        // the welcomeViewController will be updated via KVO
        // observation
    }
    
}
