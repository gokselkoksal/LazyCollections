import Foundation

public extension Array {
    
    public func manipulate<U>(_ transform: (Box<Element>) -> Box<U>) -> [U] {
        return self.flatMap { element in
            let box = Box(element)
            let transformedBox = transform(box)
            return transformedBox.value
        }
    }
}
