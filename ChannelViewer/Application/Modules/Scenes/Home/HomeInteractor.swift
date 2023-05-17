//
//  HomeInteractor.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Foundation

protocol HomeInteractorToPresenterProtocol: AnyObject {
    
}

final class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
    
    init(presenter: HomeInteractorToPresenterProtocol?) {
        self.presenter = presenter
    }
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
}
