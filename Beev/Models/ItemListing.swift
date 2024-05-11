//
//  ItemListing.swift
//  Beev
//
//  Created by Maria Concetta on 11/05/24.
//

import Foundation
import CloudKit


//ITEM LISTING: E' L'ELEMENTO ATOMICO CHE VOGLIO SALVARE NEL DB (CORRISPONDE A UN RECORD)
struct ItemListing{

    //CAMPI DEL RECORD
    var recordId: CKRecord.ID?
    let title: String
    let price: Decimal
    
    //INIZIALIZZAZIONE
    init(recordId: CKRecord.ID? = nil, title: String, price: Decimal){
        self.title = title
        self.price = price
        self.recordId = recordId
    }
    
    
    //FUNZIONE DI UTILITA': CONVERSIONE
    func toDictionary() -> [String: Any]{
        return ["title": title, "price": price]
    }
    
    //funzione che converte un record dal db a un oggetto itemlisting
    static func fromRecord(_ record:CKRecord) -> ItemListing? {
        
        guard let title = record.value(forKey: "title") as? String,
                let price = record.value(forKey: "price") as? Double
        else{
            return nil
        }
        
        return ItemListing(recordId: record.recordID, title: title, price: Decimal(price))
    }
    
}

