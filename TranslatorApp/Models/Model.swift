//
//  Model.swift
//  TranslatorApp
//
//  Created by User on 8/10/20.
//  Copyright © 2020 Aidin. All rights reserved.
//

import Foundation
import SwiftGoogleTranslate
import RealmSwift

class Model: Object {
    var arrayOfLanguages: [Language] = []
    var arrayOfTranslatedWords: Results<Words>!

    func newLanguage() -> Language {
        let language = Language()
        arrayOfLanguages.append(language)
        return language
    }
}
