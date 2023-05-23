//
//  UICollectionViewExtension.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import UIKit
import DifferenceKit

extension UICollectionView {
    func reload<C>(
        using stagedChangeset: StagedChangeset<C>,
        interrupt: ((Changeset<C>) -> Bool)? = nil,
        setData: (C) -> Void,
        completion: @escaping () -> Void
    ) {
        if case .none = window, let data = stagedChangeset.last?.data {
            setData(data)
            return reloadData()
        }
        
        let dispatchGroup = DispatchGroup()
        
        for changeset in stagedChangeset {
            if let interrupt = interrupt, interrupt(changeset), let data = stagedChangeset.last?.data {
                setData(data)
                return reloadData()
            }
            
            dispatchGroup.enter()
            performBatchUpdates({
                setData(changeset.data)
                
                if !changeset.sectionDeleted.isEmpty {
                    deleteSections(IndexSet(changeset.sectionDeleted))
                }
                
                if !changeset.sectionInserted.isEmpty {
                    insertSections(IndexSet(changeset.sectionInserted))
                }
                
                if !changeset.sectionUpdated.isEmpty {
                    reloadSections(IndexSet(changeset.sectionUpdated))
                }
                
                for (source, target) in changeset.sectionMoved {
                    moveSection(source, toSection: target)
                }
                
                if !changeset.elementDeleted.isEmpty {
                    deleteItems(at: changeset.elementDeleted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementInserted.isEmpty {
                    insertItems(at: changeset.elementInserted.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                if !changeset.elementUpdated.isEmpty {
                    reloadItems(at: changeset.elementUpdated.map { IndexPath(item: $0.element, section: $0.section) })
                }
                
                for (source, target) in changeset.elementMoved {
                    moveItem(at: IndexPath(item: source.element, section: source.section), to: IndexPath(item: target.element, section: target.section))
                }
            }, completion: { completed in
                if !completed {
                    print("Batch updates didn't complete")
                }
                
                dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
}
