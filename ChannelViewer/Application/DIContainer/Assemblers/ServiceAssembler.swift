//
//  ServiceAssembler.swift
//  ChannelViewer
//
//  Created by subhajit halder on 20/05/23.
//

import Foundation
import Swinject

final class ServiceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(CoreDataWorkerProtocol.self) { _ in
            CoreDataWorker()
        }
    }
}
