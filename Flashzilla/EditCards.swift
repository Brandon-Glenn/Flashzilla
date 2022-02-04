//
//  EditCards.swift
//  Flashzilla
//
//  Created by Brandon Glenn on 2/3/22.
//

import SwiftUI

// own array of cards to work with
// navigation view wrapped around it and button to dismiss
// list showing existing card
// swipe to delete
// add new cards
// load and save from user Defaults




struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cards =  [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                    
                }
                Section {
                    ForEach( 0 ..< cards.count, id:\.self ) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
                
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    
    func done () {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    
    func saveData() {
        if let  data = try? JSONEncoder().encode(cards)  {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    
    func removeCards(at offset: IndexSet) {
        cards.remove(atOffsets: offset)
    }
    
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        
        cards.insert(card, at: 0)
        saveData()
    }
    
}

struct EditCards_Previews: PreviewProvider {
    
    static var previews: some View {
        EditCards()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
