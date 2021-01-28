//
//  ContentView.swift
//  BarNote
//
//  Created by Pradyun Setti on 25/01/21.
//

import SwiftUI
import CoreData
import Foundation

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: NoteItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NoteItem.timestamp, ascending: false)])
    var fetchedNotes: FetchedResults<NoteItem>
    @State private var addNoteScreen: Bool = false
    @State private var noteTitle: String = ""
    
    var body: some View {
        VStack {
            Button(action: {withAnimation{ addNoteScreen.toggle() }},
                   label: { Text("Add Note") }
            )
            if addNoteScreen {
                Form() {
                    TextField("Note Title", text: $noteTitle)
                    Button(action: { addNoteItem() },
                           label: { Text("Save") }
                    )
                }
            }
            ScrollView {
                ForEach(fetchedNotes, id: \.self) { note in
                    NoteListView(noteItem: note)
                }
            }
        }
        .padding()
    }
    
    func addtestnote() {
        let newNote = NoteItem(context: moc)
        newNote.title = "Title"
        newNote.body = "Body"
    }
    
    private func addNoteItem() {
        let newNote = NoteItem(context: moc)
        newNote.title = noteTitle
        newNote.timestamp = Date()
        
        try? moc.save()
        noteTitle = ""
        withAnimation{addNoteScreen.toggle()}
    }
    
}

struct NoteListView: View {
    @Environment(\.managedObjectContext) var moc
    var noteItem: NoteItem
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(noteItem.title ?? "")
                    .padding()
                    .font(.title)
                Text(noteItem.body ?? "")
                    .padding()
                    .font(.body)
            }
            Spacer()
            Button(action: {withAnimation{ deleteItem(noteItem) }}, label: {
                Image(systemName: "trash")
                    .renderingMode(.original)
                    .foregroundColor(.white)
            })
            .padding()
        }
        .padding()
        .frame(width: 250, height: 100, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(17)
    }
    
    func deleteItem(_ item: NoteItem) {
        moc.delete(item)
        
        try? moc.save()
    }
    
}
