//
//  CustomGridCollectionViewLayout.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit

class CustomGridCollectionViewLayout: UICollectionViewLayout {
 
    weak var delegate: UICollectionViewDelegateCustomGridLayout? {
        get {
            return collectionView!.delegate as? UICollectionViewDelegateCustomGridLayout
        }
    }

    private var columnHeights: [[CGFloat]] = []
    private var attributesForSectionItems: [[UICollectionViewLayoutAttributes]] = []
    private var attributesForAllElements: [UICollectionViewLayoutAttributes] = []
    private var unionRects: [CGRect] = []
    private let unionSize = 20
    
    override func prepare() {
        super.prepare()
        let numberOfSections = collectionView!.numberOfSections
        guard numberOfSections > 0 else {
            return
        }
        unionRects = []
        attributesForAllElements = []
        attributesForSectionItems = .init(repeating: [], count: numberOfSections)
        columnHeights = .init(repeating: [], count: numberOfSections)
        var attributes = UICollectionViewLayoutAttributes()
        for section in 0..<numberOfSections {
            let sectionInset = inset(forSection: section)
            let numberOfColumns = numberOfColumns(inSection: section)
            let columnSpacing = columnSpacing(forSection: section)
            let intervalItemSpacing = intervalItemSpacing(forSection: section)
            let effectiveItemWidth = effectiveItemWidth(inSection: section)
            columnHeights[section] = [CGFloat](repeating: 0, count: numberOfColumns)
            let numberOfItems = collectionView!.numberOfItems(inSection: section)
            for item in 0..<numberOfItems {
                let indexPath = IndexPath(item: item, section: section)
                let currentColumnIndex = columnIndex(forItemAt: indexPath)
                let xOffset = sectionInset.left + (effectiveItemWidth + columnSpacing) * CGFloat(currentColumnIndex)
                let yOffset = columnHeights[section][currentColumnIndex]
                let referenceItemSize = itemSize(at: indexPath)
                let effectiveItemHeight = (effectiveItemWidth * referenceItemSize.height / referenceItemSize.width)
                attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: effectiveItemWidth, height: effectiveItemHeight)
                attributesForSectionItems[section].append(attributes)
                attributesForAllElements.append(attributes)
                columnHeights[section][currentColumnIndex] = attributes.frame.maxY + intervalItemSpacing
            }
        }
        let count = attributesForAllElements.count
        var i = 0
        while i < count {
            let rect1 = attributesForAllElements[i].frame
            i = min(i + unionSize, count) - 1
            let rect2 = attributesForAllElements[i].frame
            unionRects.append(rect1.union(rect2))
            i += 1
        }
    }
    
    override var collectionViewContentSize: CGSize {
        guard collectionView!.numberOfSections > 0 else {
            return .zero
        }
        var collectionViewContentHeight: CGFloat = 0
        columnHeights.last?.forEach({ height in
            if height > collectionViewContentHeight {
                collectionViewContentHeight = height
            }
        })
        guard collectionViewContentHeight > 0 else {
            return .zero
        }
        return .init(width: collectionView!.bounds.size.width, height: collectionViewContentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.section >= attributesForSectionItems.count {
            return nil
        }
        let list = attributesForSectionItems[indexPath.section]
        if indexPath.item >= list.count {
            return nil
        }
        return list[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var begin = 0, end = unionRects.count
        if let i = unionRects.firstIndex(where: { rect.intersects($0) }) {
            begin = i * unionSize
        }
        if let i = unionRects.lastIndex(where: { rect.intersects($0) }) {
            end = min((i + 1) * unionSize, attributesForAllElements.count)
        }
        return attributesForAllElements[begin..<end].filter { rect.intersects($0.frame) }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.width != collectionView!.bounds.width
    }

    // MARK: - Helpers func
    private func columnIndex(forItemAt indexPath: IndexPath) -> Int {
        return shortestColumnIndex(inSection: indexPath.section)
    }
    
    private func shortestColumnIndex(inSection section: Int) -> Int {
        return columnHeights[section].enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
    }
        
    private func effectiveContentWidth(forSection section: Int) -> CGFloat {
        let sectionInset = inset(forSection: section)
        return collectionView!.bounds.size.width - sectionInset.left - sectionInset.right
    }
    
    private func effectiveItemWidth(inSection section: Int) -> CGFloat {
        let numberOfColumns = numberOfColumns(inSection: section)
        let columnSpacing = columnSpacing(forSection: section)
        let sectionContentWidth = effectiveContentWidth(forSection: section)
        let width = (sectionContentWidth - (columnSpacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
        assert(width >= 0, "Item's width should be negative value.")
        return width
    }
    
    private func itemSize(at indexPath: IndexPath) -> CGSize {
        let referenceItemSize = delegate?.collectionView(collectionView!, layout: self, sizeForItemAt: indexPath) ?? .init(width: 100, height: 100)
        assert(referenceItemSize.width.isNormal && referenceItemSize.height.isNormal, "Item size values must be not zero, infinity or nil.")
        return referenceItemSize
    }
    
    private func numberOfColumns(inSection section: Int) -> Int {
        let numberOfColumns = delegate?.collectionView(collectionView!, layout: self, numberOfColumnsInSection: section) ?? 1
        assert(numberOfColumns > 0, "The number of columns must be greater than zero.")
        return numberOfColumns
    }
    
    private func inset(forSection section: Int) -> UIEdgeInsets {
        return delegate?.collectionView(collectionView!, layout: self, insetForSectionAt: section) ?? .zero
    }
    
    private func columnSpacing(forSection section: Int) -> CGFloat {
        return delegate?.collectionView(collectionView!, layout: self, minimumColumnSpacingForSectionAt: section) ?? 0
    }
    
    private func intervalItemSpacing(forSection section: Int) -> CGFloat {
        return delegate?.collectionView(collectionView!, layout: self, minimumIntervalItemSpacingForSectionAt: section) ?? 0
    }
    
}
