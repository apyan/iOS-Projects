//
//  Dex3WidgetBundle.swift
//  Dex3Widget
//
//  Created by Alvin on 2/1/25.
//

import WidgetKit
import SwiftUI

@main
struct Dex3WidgetBundle: WidgetBundle {
    var body: some Widget {
        Dex3Widget()
        Dex3WidgetControl()
        Dex3WidgetLiveActivity()
    }
}
