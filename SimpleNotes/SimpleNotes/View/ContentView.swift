//  ContentView.swift
//  SimpleNotes

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.timestamp, ascending: false)],
        predicate: NSPredicate(format: "isDeletedNote == NO"),
        animation: .default)
    private var notes: FetchedResults<NoteEntity>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: EditNoteView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "")
                                .font(.headline)
                            if let noteBody = note.noteBody {
                                AttributedTextEditor.displayText(noteBody)
                                    .lineLimit(2)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Simple Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: TrashView()) {
                        Image(systemName: "trash")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNoteView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    private func deleteNotes(offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            note.isDeletedNote = true
        }

        try? viewContext.save()
    }
}
