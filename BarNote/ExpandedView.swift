//
//  ExpandedView.swift
//  BarNote
//
//  Created by Pradyun Setti on 29/01/21.
//

import SwiftUI

struct ExpandedView: View {
    @Environment(\.presentationMode) var presentationMode
    let note: NoteItem
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: { self.presentationMode.wrappedValue.dismiss() },
                   label: { Image(systemName: "xmark.square.fill") }
            )
            Text(note.title ?? "(no title)")
                .font(.title2)
                .foregroundColor(.white)
                .bold()
                .lineLimit(1)
            Text(note.body ?? "no description")
                .padding()
//                .padding(.top, 20)
            Spacer()
        }
        .padding()
        .frame(width: 200, height: 250, alignment: .leading)
//        .background(Color.blue)
//        .cornerRadius(17)
    }
}

//struct ExpandedView_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    
//    static var previews: some View {
//        let newnote = NoteItem(context: moc)
//        newnote.title = "title"
//        newnote.body = "body"
//        newnote.timestamp = Date()
//        
//        return NavigationView {
//            ExpandedView(note: newnote)
//        }
//    }
//}
