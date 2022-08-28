//
//  CustomLayout.swift
//  KKOApp
//
//  Created by VironIT on 22.08.22.
//

import UIKit

protocol CustomLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}

class CustomLayout: UICollectionViewLayout {
    weak var delegate: CustomLayoutDelegate?
    
    private var numberOfColumns = 2
    private var cellPadding: CGFloat = 2
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    private var isColumnChanged = false
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insert = collectionView.contentInset
        return collectionView.bounds.width - (insert.left + insert.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
      // 1
      guard
        cache.isEmpty,
        let collectionView = collectionView
        else {
          return
      }
      // 2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let photoSize = delegate?.collectionView(
                collectionView,
                heightForPhotoAtIndexPath: indexPath)
            let width = columnWidth
            var height = photoSize!.height * width/photoSize!.width
            height = cellPadding * 2 + height
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: width,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            if numberOfColumns > 1 {
                isColumnChanged = false
                for index in (1..<numberOfColumns).reversed() {
                  if yOffset[index] >= yOffset[index - 1] {
                      column = index - 1
                      isColumnChanged = true
                  }
                  else {
                      break
                  }
              }
              if isColumnChanged {
                  continue
              }
          }
          
        column = column < (numberOfColumns - 1) ? (column + 1) : 0
      }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      // Loop through the cache and look for items in the rect
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}

