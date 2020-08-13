//
//  MainTableViewController.swift
//  TranslatorApp
//
//  Created by User on 8/10/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import UIKit
import SwiftGoogleTranslate


class MainTableViewController: UITableViewController {
    
    let api = API()
    let model = Model()
    var toBeTranslatedLanguage = ""
    var translatedLanguage = ""
    var reverseVariable: (String, String) = ("", "")
    
    @IBOutlet weak var pickerViewNumberOne: UIPickerView!
    @IBOutlet weak var pickerViewNumberTwo: UIPickerView!
    @IBOutlet weak var labelToTranslate: UITextField!
    @IBOutlet weak var labelToTranslatedWord: UITextField!
    @IBOutlet weak var getImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var viewForLabels: UIView!
    @IBOutlet weak var viewForLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForLabels.layer.cornerRadius = 5
        viewForLabel.layer.cornerRadius = 5
        SwiftGoogleTranslate.shared.start(with: api.translationAPIKey)
        pickerViewNumberOne.delegate = self
        pickerViewNumberOne.dataSource = self
        pickerViewNumberTwo.delegate = self
        pickerViewNumberTwo.dataSource = self
        
        SwiftGoogleTranslate.shared.languages { (languages, error) in
            if let languages = languages {
                for language in languages {
                    let newLanguage = self.model.newLanguage()
                    DispatchQueue.main.async {
                        newLanguage.language = language.name
                        newLanguage.code = language.language
                        self.pickerViewNumberOne.reloadAllComponents()
                        self.pickerViewNumberTwo.reloadAllComponents()
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case IndexPath(row: 1, section: 1):
            return 50
        case IndexPath(row: 0, section: 1):
            return 100
        case IndexPath(row: 2, section: 1):
            return 100
        default:
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    @IBAction func translatePressed(_ sender: Any) {
        if let text1 = labelToTranslate.text {
            
            SwiftGoogleTranslate.shared.translate(text1, translatedLanguage,  toBeTranslatedLanguage) { (text, error) in
                if let t = text {
                    print(t, text1)
                    DispatchQueue.main.async {
                        self.labelToTranslatedWord.text = t
                        print(t)
                        let newWords = Words(toBeTranslatedWord: text1, translatedWord: t)
                        RealmService.shared.create(newWords)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func reverseButtonPressed(_ sender: Any) {
        reverseVariable = (toBeTranslatedLanguage, translatedLanguage)
        toBeTranslatedLanguage = reverseVariable.1
        translatedLanguage = reverseVariable.0
        getImageView.image = UIImage(named: toBeTranslatedLanguage)
        postImageView.image = UIImage(named: translatedLanguage)
    }
    
}

extension MainTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.arrayOfLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.arrayOfLanguages[row].language
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewNumberOne {
            toBeTranslatedLanguage = model.arrayOfLanguages[row].code
            getImageView.image = UIImage(named: toBeTranslatedLanguage)
            
        } else {
            translatedLanguage = model.arrayOfLanguages[row].code
            postImageView.image = UIImage(named: translatedLanguage)
        } 
    }
    
}
