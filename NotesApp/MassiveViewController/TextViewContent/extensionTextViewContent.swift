//
//  extensionTextViewContent.swift
//  NotesApp
//
//  Created by Андрей Сорокин
//

import UIKit

extension TextViewContentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let configuration = configuration as? TextViewContentView.ContenConfiguration else { return }
        configuration.onChange(textView.text)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension UIContentConfiguration {
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.ContenConfiguration {
        TextViewContentView.ContenConfiguration()
    }
}
