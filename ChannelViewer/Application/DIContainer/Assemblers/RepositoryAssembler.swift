//
//  RepositoryAssembler.swift
//  ChannelViewer
//
//  Created by subhajit halder on 20/05/23.
//

import Foundation
import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeRepository.self) { resolver in
            let remoteDS = resolver.resolve(HomeRemoteDataSourceProtocol.self)!
            let localDS = resolver.resolve(HomeLocalDataSourceProtocol.self)!
            
            return HomeDataRepository(remoteDataSource: remoteDS, localDataSource: localDS)
        }
    }
}
