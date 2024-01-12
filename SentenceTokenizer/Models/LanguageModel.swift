//
//  LanguageModel.swift
//  SentenceTokenizer
//
//  Created by Eliza Alekseeva on 1/13/24.
//

import Foundation

public enum SupportedLanguage: String {
    case english = "English"
    case spanish = "Spanish"
}

public struct LanguageModel {
    var triggerWords: [String]
    
    init(language: SupportedLanguage) {
        switch language {
        case .english:
            triggerWords = ["if", "and"]
        case .spanish:
            triggerWords = ["si", "y"]
        }
    }
}

