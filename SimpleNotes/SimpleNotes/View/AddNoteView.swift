//  AddNoteView.swift
//  SimpleNotes

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = NoteViewModel()
    
    var body: some View {
        VStack {
            TextField("Add a title", text: $viewModel.title)
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
                
                Button("Add") {
                    let newNote = NoteEntity(context: viewContext)
                    newNote.title = viewModel.title
                    newNote.noteBody = viewModel.noteBody
                    newNote.timestamp = Date()
                    newNote.isDeletedNote = false
                    try? viewContext.save()
                    dismiss()
                }
                .disabled(viewModel.title.isEmpty)
            }
            .padding()
        }
        .navigationTitle("New note")
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
