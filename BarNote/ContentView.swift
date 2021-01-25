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
    @FetchRequest(entity: NoteItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \NoteItem.timestamp, ascending: true)])
    var fetchedNotes: FetchedResults<NoteItem>
    
    var body: some View {
        VStack {
            Button(action: {addtestnote()}, label: {
                Text("Add Note")
            })
            ScrollView {
                ForEach(fetchedNotes, id: \.self) { note in
                    NoteListView(noteItem: note)
                }
                .padding()
            }
        }
        .padding()
    }
    
    func addtestnote() {
        let newNote = NoteItem(context: moc)
        newNote.title = "Title"
        newNote.body = "Body"
        
//        try? moc.save()
    }
    
}

struct NoteListView: View {
    var noteItem: NoteItem
    
    var body: some View {
        VStack {
            Text(noteItem.title ?? "")
                .padding()
                .font(.title)
            Text(noteItem.body ?? "")
                .padding()
                .font(.body)
        }
        .frame(width: 250, height: 100, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(17)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
