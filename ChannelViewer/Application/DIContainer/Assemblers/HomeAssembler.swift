//
//  HomeAssembler.swift
//  ChannelViewer
//
//  Created by subhajit halder on 09/05/23.
//

import Foundation
import Swinject

final class HomeAssembly: Assembly {
    
    typealias Presenter = HomeInteractorToPresenterProtocol & HomeViewToPresenterProtocol
    typealias Interactor = HomePresenterToInteractorProtocol
    typealias View = HomePresenterToViewProtocol
    
    func assemble(container: Swinject.Container) {
        container.register(Interactor.self) { resolver in
            let presenter = resolver.resolve(HomeInteractorToPresenterProtocol.self)
            return HomeInteractor(presenter: presenter)
        }
        
        container.register(Presenter.self) { resolver in
            let view = resolver.resolve(HomePresenterToViewProtocol.self)
            let interactor = resolver.resolve(HomePresenterToInteractorProtocol.self)
            return HomePresenter(view: view, interactor: interactor)
        }
        
        container.register(View.self) { resolver in
            let presenter = resolver.resolve(HomeViewToPresenterProtocol.self)
            return HomeVC(presenter: presenter)
        }
        
    }
}
