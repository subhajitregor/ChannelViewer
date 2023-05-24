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
    func fetchNext()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> CellViewAnyModel?
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func onSuccess(channelsAndPrograms: [ChannelItem])
    func onFailure(error: Error)
}

protocol HomePresenterToRouterProtocol {
    // TODO: implementation
}

extension HomePresenter {
    struct Section: SectionViewModel {
        var id: Int
        var channelModel: ChannelCVCellModel?
        var cells: [CellViewAnyModel]
        
        var differenceIdentifier: Int {
            return id
        }
        
        func isContentEqual(to source: HomePresenter.Section) -> Bool {
            let equalChannel: Bool = {
                switch (self.channelModel, source.channelModel) {
                case (.none, .none): return true
                case let (.some(left), .some(right)): return left.isContentEqual(to: right)
                default: return false
                }
            }()
            return self.id == source.id
            && equalChannel
            && self.cellsEqualTo(source.cells)
        }
    }
}

extension HomePresenter.Section: DifferentiableSection {
    typealias Collection = [AnyDifferentiable]
    init<C>(source: HomePresenter.Section, elements: C) where C: Swift.Collection, C.Element == HomePresenter.Section.Collection.Element {
        self.id = source.id
        self.channelModel = source.channelModel
        self.cells = elements.compactMap { $0.base as? CellViewAnyModel }
    }
}

final class HomePresenter {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    private var sectionsArray: [HomePresenter.Section] = []
    
    private let verticalPage = Page(currentPageNo: 0, limit: 5)
    private let horizontalPage = Page(currentPageNo: 0, limit: 10)
}

extension HomePresenter: HomeViewToPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        verticalPage.startFetching()
        interactor?.fetchChannelsAndPrograms(from: verticalPage.currentOffset(), limit: verticalPage.maxlimit())
    }
    
    func fetchNext() {
        if !verticalPage.isFetching && !verticalPage.isLastPageFetched {
            view?.showLoader()
            verticalPage.startFetching()
            interactor?.fetchChannelsAndPrograms(from: verticalPage.nextOffset(), limit: verticalPage.maxlimit())
        }
    }
    
    func numberOfSections() -> Int {
        sectionsArray.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        sectionsArray[section].cells.count + 1
    }
    
    func item(at indexPath: IndexPath) -> CellViewAnyModel? {
        if indexPath.item == 0 {
            return sectionsArray[indexPath.section].channelModel
        } else {
            return sectionsArray[indexPath.section].cells[indexPath.item - 1]
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
        
        if channelsAndPrograms.count < verticalPage.maxlimit() {
            verticalPage.lastPageFetched()
        }
        let newSection = createCells(from: channelsAndPrograms)
        let targetArray = sectionsArray + newSection
        view?.hideLoader()
        let stagedChangeSet = StagedChangeset(source: self.sectionsArray, target: targetArray)
        if !stagedChangeSet.isEmpty {
            view?.reloadData(with: stagedChangeSet, completion: { collection in
                self.sectionsArray = collection
                self.verticalPage.fetchComplete()
            })
        }
        
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
            return Section(id: model.channelId, channelModel: model, cells: elements)
        }
        return section
    }
}
