//
//  TokenizerViewModel.swift
//  SentenceTokenizer
//
//  Created by Eliza Alekseeva on 1/13/24.
//

import Foundation

class TokenizerViewModel {
    var model = TokenizerModel()
    var languageModel: LanguageModel?
    
    func setLanguage(_ language: SupportedLanguage) {
        languageModel = LanguageModel(language: language)
    }
    
    func tokenizeSentence(_ sentence: String) {
        guard let languageModel = languageModel else {
            print("Language not set")
            return
        }
        
        let triggerWords = languageModel.triggerWords
        let words = sentence.components(separatedBy: " ")
        
        var components = [String]()
        var newSentence = ""
        
        for word in words {
            if !triggerWords.contains(word.lowercased()) {
                newSentence += " \(word)"
            } else {
                components.append(newSentence)
                newSentence = word
            }
        }
        
        components.append(newSentence)
        
        model.sentences = components.filter { !$0.isEmpty }
    }
}
