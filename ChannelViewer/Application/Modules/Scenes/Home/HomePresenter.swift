//
//  HomePresenter.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Foundation
import PromiseKit
import DifferenceKit

protocol HomeViewToPresenterProtocol {
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> CellViewAnyModel?
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func onSuccess(channelsAndPrograms: [ChannelItem])
    func onFailure(error: Error)
}

protocol HomePresenterToRouterProtocol {
    
}

final class HomePresenter {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    typealias Section = ArraySection<ChannelCVCellModel, ProgramCVCellModel>
    private var sectionsArray = [Section]()
    private let verticalPage = Page(currentPageNo: 0, limit: 5)
    private let horizontalPage = Page(currentPageNo: 0, limit: 10)
}

extension HomePresenter: HomeViewToPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor?.fetchChannelsAndPrograms()
    }
    
    func numberOfSections() -> Int {
        sectionsArray.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        sectionsArray[section].elements.count + 1
    }
    
    func item(at indexPath: IndexPath) -> CellViewAnyModel? {
        if indexPath.item == 0 {
            return sectionsArray[indexPath.section].model
        } else {
            return sectionsArray[indexPath.section].elements[indexPath.item - 1]
        }
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func onSuccess(channelsAndPrograms: [ChannelItem]) {
        let dateOfPrograms = channelsAndPrograms.first?.program
            .map { $0.startTime?.toDate()}
            .sorted(by: {$0?.compare($1 ?? Date()) == .orderedAscending})
            .map { $0?.toString(format: .fullCompact)}
        dateOfPrograms?.forEach { date in
            print(date!)
        }
        
        let newSection = createCells(from: channelsAndPrograms)
        let stagedChangeset = StagedChangeset(source: self.sectionsArray, target: newSection)
        
        view?.hideLoader()
        view?.reloadData(with: stagedChangeset, completion: { collection in
            self.sectionsArray = collection
        })
    }
    
    func onFailure(error: Error) {
        print(error)
        view?.hideLoader()
    }
}

// MARK: - Private Methods
extension HomePresenter {
    func createCells(from array: [ChannelItem]) -> [Section] {
        let section = array.compactMap { item in
            let model = ChannelCVCellModel(channelId: item._id ?? 0, name: item.callSign ?? "No Channel Name")
            let elements = item.program.compactMap { ProgramCVCellModel(programId: $0._id ?? 0, name: $0.name ?? "")}
            return Section(model: model, elements: elements)
        }
        return section
    }
}
