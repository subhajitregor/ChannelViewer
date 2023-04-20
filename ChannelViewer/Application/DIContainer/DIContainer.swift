//
//  DIContainer.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Swinject

final class DIContainer {
    static let shared = DIContainer ()
    
    let container = Container()
    let assembler: Assembler
    
    private init() {
        self.assembler = Assembler(
            [
                
            ],
            container: container)
    }
}

