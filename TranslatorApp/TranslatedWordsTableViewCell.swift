//
//  TranslatedWordsTableViewCell.swift
//  TranslatorApp
//
//  Created by User on 8/10/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import UIKit

class TranslatedWordsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toBeTranslatedWord: UILabel!
    @IBOutlet weak var translatedWord: UILabel!
    @IBOutlet weak var viewForTranslation: UIView!
    
    
    var words: Words! {
        didSet {
            toBeTranslatedWord.text = words.toBeTranslatedWord
            translatedWord.text = words.translatedWord
            viewForTranslation.layer.cornerRadius = 5
        }
    }
}
