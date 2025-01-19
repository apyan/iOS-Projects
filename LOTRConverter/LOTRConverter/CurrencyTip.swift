//
//  CurrencyTip.swift
//  LOTRConverter
//
//  Created by Alvin on 1/16/25.
//

import TipKit

// TipKit is used to help users navigate throughout your app
struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    var message: Text? = Text("You can tap the left or right currency to bring up the Select Currency screen.")
    
    var image: Image? = Image(systemName: "hand.tap.fill")
}
