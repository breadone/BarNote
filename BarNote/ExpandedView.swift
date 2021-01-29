//
//  ExpandedView.swift
//  BarNote
//
//  Created by Pradyun Setti on 29/01/21.
//

import SwiftUI

struct ExpandedView: View {
    let note: NoteItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(common.DateToString(note.timestamp ?? Date()))
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.white)
            Text(note.title ?? "(no title)")
                .font(.title2)
                .foregroundColor(.white)
                .bold()
                .lineLimit(1)
            Text(note.body ?? "(no more info)")
                .font(.body)
                .lineLimit(2)
                .foregroundColor(.white)        }
        .padding()
        .frame(width: 250, height: 350, alignment: .leading)
        .background(Color.blue)
        .cornerRadius(17)
    }
}

struct ExpandedView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let newnote = NoteItem(context: moc)
        newnote.title = "title"
        newnote.body = "body"
        newnote.timestamp = Date()
        
        return NavigationView {
            ExpandedView(note: newnote)
        }
    }
}
