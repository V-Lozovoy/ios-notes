//  NoteViewModel.swift
//  SimpleNotes

import CoreData
import SwiftUI

class NoteViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var noteBody: NSAttributedString = NSAttributedString(string: "")
    @Published var selectedRange: NSRange = NSRange(location: 0, length: 0)
    
    
    // Стилізується не весь опис нотатки, а саме виділений текст
    func applyStyle(_ style: TextStyle) {
        guard selectedRange.length > 0 else { return }
        let mutable = NSMutableAttributedString(attributedString: noteBody)
        let attributes = style.attributes
        
        mutable.addAttributes(attributes, range: selectedRange)
        noteBody = mutable
    }
    
    func reset() {
        title = ""
        noteBody = NSAttributedString(string: "")
        selectedRange = NSRange(location: 0, length: 0)
    }
    
    // Визначаємо доступні стилі для форматування тексту
    enum TextStyle {
        case bold, italic, underline
        
        var attributes: [NSAttributedString.Key: Any] {
            switch self {
            case .bold:
                return [.font: UIFont.boldSystemFont(ofSize: 16)]
                
            case .italic:
                return [.font: UIFont.italicSystemFont(ofSize: 16)]
            
            case .underline:
                return [.underlineStyle: NSUnderlineStyle.single.rawValue]
            }
        }
    }
}
