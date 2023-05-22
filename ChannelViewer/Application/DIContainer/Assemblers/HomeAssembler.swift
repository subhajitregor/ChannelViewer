//
//  HomeAssembler.swift
//  ChannelViewer
//
//  Created by subhajit halder on 09/05/23.
//

import Foundation
import Swinject

final class HomeAssembly: Assembly {
    
    typealias View = HomeVC
    typealias Interactor = HomePresenterToInteractorProtocol
    typealias Presenter = HomePresenter
    
    func assemble(container: Swinject.Container) {
        container.register(Interactor.self) { (resolver, presenter: Presenter) in
            let interactor = HomeInteractor()
            interactor.presenter = presenter
            interactor.repository = resolver.resolve(HomeRepository.self)
            return interactor
        }
        
        container.register(Presenter.self) { (resolver, view: View) in
            let presenter = HomePresenter()
            presenter.interactor = resolver.resolve(Interactor.self, argument: presenter)
            presenter.view = view
            return presenter
        }
        
        container.register(View.self) { resolver in
            let view = HomeVC()
            let presenter = resolver.resolve(Presenter.self, argument: view)
            view.presenter = presenter
            return view
        }
        
    }
}
