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
    @State private var noteBody: String = ""
    @State private var colour: String = "blue"
    
    @State private var selectedNote: NoteItem? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {withAnimation{ addNoteScreen.toggle() }},
                       label: { Text("Add Note").foregroundColor(.primary) }
                )
                Spacer()
                Button(action: { NSApplication.shared.terminate(self) },
                       label: { Text("Quit").foregroundColor(.primary) }
                )
            }
            if addNoteScreen {
                HStack() {
                    ForEach(0 ..< common.colours.count) { c in
                        colourView(colour: common.colours[c])
                            .onTapGesture {
                                colour = common.colours[c]
                            }
                    }
                }
                Form() {
                        TextField("", text: $noteTitle)
                        TextEditor(text: $noteBody)
                            .lineLimit(10)
                    Button(action: { addNoteItem() },
                           label: { Text("Save").foregroundColor(common.colourDict[colour]) }
                    )
                }
            }
            ScrollView {
                ForEach(fetchedNotes, id: \.self) { noteIn in
                    NoteListView(noteItem: noteIn)
                        .onTapGesture {
                            self.selectedNote = noteIn
                        }
                }
            }
            .sheet(item: self.$selectedNote, content: { noteIn in
                ExpandedView(note: noteIn)
            })
        }
        .padding()
    }
    
    
    private func addNoteItem() {
        let newNote = NoteItem(context: moc)
        newNote.title = noteTitle
        newNote.body = noteBody
        newNote.timestamp = Date()
        newNote.colour = colour
        
        try? moc.save()
        noteTitle = ""
        noteBody = ""
        colour = "blue"
        withAnimation{addNoteScreen.toggle()}
    }    
}

struct colourView: View {
    let colour: String
    static var chosenColour = "blue"
    
    var body: some View {
        Circle()
            .strokeBorder(Color.white,lineWidth: 2.5)
            .background(Circle().foregroundColor(common.colourDict[colour]))
            .frame(width: 30, height: 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
