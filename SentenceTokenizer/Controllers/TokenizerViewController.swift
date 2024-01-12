//
//  ViewController.swift
//  SentenceTokenizer
//
//  Created by Eliza Alekseeva on 1/13/24.
//

import UIKit

class TokenizerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let viewModel = TokenizerViewModel()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a sentence"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let languageSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["English", "Spanish"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(inputTextField)
        view.addSubview(languageSegmentedControl)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            languageSegmentedControl.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            languageSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let tokenizeButton = UIButton(type: .system)
        tokenizeButton.setTitle("Tokenize", for: .normal)
        tokenizeButton.addTarget(self, action: #selector(tokenizeButtonTapped), for: .touchUpInside)
        tokenizeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tokenizeButton)
        
        NSLayoutConstraint.activate([
            tokenizeButton.topAnchor.constraint(equalTo: languageSegmentedControl.bottomAnchor, constant: 20),
            tokenizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(TokenCell.self, forCellWithReuseIdentifier: "TokenCell")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tokenizeButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.sentences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TokenCell", for: indexPath) as? TokenCell else {
            fatalError("Unable to dequeue TokenCell")
        }
        
        let sentence = viewModel.model.sentences[indexPath.item]
        cell.configure(with: sentence)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sentence = viewModel.model.sentences[indexPath.item]
        let size = TokenCell.sizeForText(sentence)
        return CGSize(width: min(size.width + 16, collectionView.bounds.width - 40), height: size.height + 8)
    }
    
    @objc func tokenizeButtonTapped() {
        guard let sentence = inputTextField.text, !sentence.isEmpty else { return }
        let languageIndex = languageSegmentedControl.selectedSegmentIndex
        let language: SupportedLanguage = languageIndex == 0 ? .english : .spanish
        
        viewModel.setLanguage(language)
        viewModel.tokenizeSentence(sentence)
        
        collectionView.reloadData()
    }
}

