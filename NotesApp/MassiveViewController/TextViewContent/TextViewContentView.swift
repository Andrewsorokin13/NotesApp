//
//  TextViewContentView.swift
//  NotesApp
//
//  Created by Андрей Сорокин

import UIKit



class TextViewContentView: UIView , UIContentView {
    struct ContenConfiguration: UIContentConfiguration {
        var text: String? = ""
        var onChange: (String) -> Void = { _ in }
        
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
    }
    
    lazy var textView = UITextView()
    var configuration: UIContentConfiguration {
        didSet {
            configure(configure: configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addSubView(textView, height: 600)
        textView.backgroundColor = nil
        textView.delegate = self
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 400)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configure: UIContentConfiguration) {
        guard let configuration = configure as? ContenConfiguration else { return }
        textView.text = configuration.text
    }
}


