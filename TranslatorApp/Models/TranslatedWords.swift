//
//  TranslatedWords.swift
//  TranslatorApp
//
//  Created by User on 8/10/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import Foundation
import RealmSwift

class Words: Object {
    @objc dynamic var toBeTranslatedWord: String = ""
    @objc dynamic var translatedWord: String = ""
    
    convenience init(toBeTranslatedWord: String, translatedWord: String) {
        self.init()
        self.toBeTranslatedWord = toBeTranslatedWord
        self.translatedWord = translatedWord
    }
}
