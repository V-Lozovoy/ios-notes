//  EditNoteView.swift
//  SimpleNotes

import SwiftUI

struct EditNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var note: NoteEntity
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        VStack {
            TextField("Title", text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .font(.headline)
            
            formattingToolbar
            
            AttributedTextEditor(attributedText: $viewModel.noteBody, selectedRange: $viewModel.selectedRange).frame(minHeight: 200).padding()
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    note.title = viewModel.title
                    note.noteBody = viewModel.noteBody
                    try? viewContext.save()
                    dismiss()
                }
                .disabled(viewModel.title.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Edit")
        .onAppear {
            viewModel.title = note.title ?? ""
            viewModel.noteBody = note.noteBody ?? NSAttributedString(string: "")
        }
    }
    
    private var formattingToolbar: some View {
        HStack {
            Button(action: { viewModel.applyStyle(.bold) }) {
                Image(systemName: "bold")
            }
            Button(action: { viewModel.applyStyle(.italic) }) {
                Image(systemName: "italic")
            }
            Button(action: { viewModel.applyStyle(.underline) }) {
                Image(systemName: "underline")
            }
        }
        .padding(.horizontal)
    }
}
