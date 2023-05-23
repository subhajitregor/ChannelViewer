//
//  CellViewAnyModel.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import UIKit
import DifferenceKit

extension Array where Element == CellViewAnyModel {
    static func == (left: Self, right: Self) -> Bool {
        guard left.count == right.count else { return false }
        return !zip(left, right).contains { !$0.0.anyDifferentiable.isContentEqual(to: $0.1.anyDifferentiable) }
    }
}

protocol SectionViewModel {
    var cells: [CellViewAnyModel] { get }
}

extension SectionViewModel {
    func cellsEqualTo(_ cells: [CellViewAnyModel]) -> Bool {
        return self.cells == cells
    }
}

extension DifferentiableSection where Self: SectionViewModel {
    var elements: [AnyDifferentiable] {
        return cells.map { $0.anyDifferentiable }
    }
}


protocol CellViewAnyModel {
    static var cellAnyType: UIView.Type { get }
    static var identifier: String { get }
    var height: CGFloat { get }
    var width: CGFloat { get }
    var estimatedHeight: CGFloat { get }
    func setupAny(cell: UIView)
    func updateAny(cell: UIView)
    func onClickAny(cell: UIView)
    var anyDifferentiable: AnyDifferentiable { get }
}

extension CellViewAnyModel {
    var height: CGFloat { CGFloat.greatestFiniteMagnitude }
    var width: CGFloat { CGFloat.greatestFiniteMagnitude }
    var estimatedHeight: CGFloat { CGFloat.greatestFiniteMagnitude }
}

protocol CellViewModel: CellViewAnyModel, Hashable, Differentiable {
    associatedtype CellType: UIView
    func setup(cell: CellType)
    func update(cell: CellType)
    var onClick: ((CellType) -> Void)? { get }
}

extension CellViewModel {
    static var cellAnyType: UIView.Type { return CellType.self }
    static var identifier: String { return String(describing: self) }

    func setupAny(cell: UIView) {
        guard let castedCell = cell as? CellType else {
            fatalError("Cannot cast cell \(cell) to \(CellType.self)")
        }
        self.setup(cell: castedCell)
    }

    func updateAny(cell: UIView) {
        guard let castedCell = cell as? CellType else {
            fatalError("Cannot cast cell \(cell) to \(CellType.self)")
        }
        self.update(cell: castedCell)
    }

    func onClickAny(cell: UIView) {
        guard let castedCell = cell as? CellType else {
            fatalError("Cannot cast cell \(cell) to \(CellType.self)")
        }
        onClick?(castedCell)
    }

    func update(cell: CellType) { }
    
    var hashValue: Int { fatalError("Implement 'differenceIdentifier' AND 'isContentEqual(to source: CellModel) -> Bool'") }
    
    func hash(into hasher: inout Hasher) {
        fatalError("Override")
    }

    static func == (lhs: Self, rhs: Self) -> Bool { fatalError("Override") }

    var anyDifferentiable: AnyDifferentiable {
        return AnyDifferentiable(self)
    }
}

// MARK: UICollectionView

extension UICollectionView {

    func dequeueReusableCell(
        with model: CellViewAnyModel,
        for indexPath: IndexPath
        ) -> UICollectionViewCell {

        let identifier = type(of: model).identifier
        let cell = self.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        )

        model.setupAny(cell: cell)

        return cell
    }

    func dequeueReusableSupplementaryView(
        with model: CellViewAnyModel,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {

        let identifier = type(of: model).identifier

        let reusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        model.setupAny(cell: reusableView)

        return reusableView
    }

    func register(classes: [CellViewAnyModel.Type]) {
        for model in classes {
            let identifier = model.identifier
            self.register(model.cellAnyType, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func register(classes: [CellViewAnyModel.Type], forSupplementaryViewOfKind: String) {
        for model in classes {
            let identifier = model.identifier
            self.register(model.cellAnyType, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: identifier)
        }
    }
}
