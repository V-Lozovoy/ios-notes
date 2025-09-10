//  TrashView.swift
//  SimpleNotes

import SwiftUI

struct TrashView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.timestamp, ascending: false)],
        predicate: NSPredicate(format: "isDeletedNote == YES"),
        animation: .default)
    private var deletedNotes: FetchedResults<NoteEntity>

    var body: some View {
        List {
            ForEach(deletedNotes) { note in
                VStack(alignment: .leading) {
                    Text(note.title ?? "")
                        .font(.headline)
                    if let body = note.noteBody {
                        AttributedTextEditor.displayText(body)
                            .lineLimit(2)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewContext.delete(note)
                        try? viewContext.save()
                    } label: {
                        Label("Delete", systemImage: "delete.backward.fill")
                    }

                    Button {
                        note.isDeletedNote = false
                        try? viewContext.save()
                    } label: {
                        Label("Restore", systemImage: "arrow.up.trash.fill")
                    }
                    .tint(.green)
                }
            }
        }
        .navigationTitle("Deleted notes")
    }
}
