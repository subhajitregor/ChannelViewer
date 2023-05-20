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
                HomeAssembly(),
                ServiceAssembly(),
                DataSourceAssembly(),
                RepositoryAssembly()
            ],
            container: container)
    }
    
    func resolve<T>() -> T {
        guard let resolvedType = container.resolve(T.self) else {
            fatalError()
        }
        return resolvedType
    }

}

