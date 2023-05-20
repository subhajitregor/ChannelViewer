//
//  DataSourceAssembler.swift
//  ChannelViewer
//
//  Created by subhajit halder on 20/05/23.
//

import Foundation
import Swinject

final class DataSourceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(HomeRemoteDataSourceProtocol.self) { _ in
            HomeRemoteDataSource()
        }
        
        container.register(HomeLocalDataSourceProtocol.self) { resolver in
            HomeLocalDataSource(worker: resolver.resolve(CoreDataWorkerProtocol.self))
        }
    }
}
