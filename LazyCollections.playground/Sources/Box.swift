import Foundation

public enum Box<T> {
    
    case filled(T)
    case empty
    
    public init(_ value: T?) {
        switch value {
        case .some(let wrapped):
            self = Box<T>.filled(wrapped)
        case .none:
            self = Box<T>.empty
        }
    }
    
    public var value: T? {
        switch self {
        case .filled(let value):
            return value
        case .empty:
            return nil
        }
    }
    
    public func map<U>(_ transform: (T) -> U) -> Box<U> {
        switch self {
        case .filled(let value):
            let newValue: U = transform(value)
            return Box<U>(newValue)
        case .empty:
            return Box<U>.empty
        }
    }
    
    public func mapSome<U>(_ transform: (T) -> U?) -> Box<U> {
        switch self {
        case .filled(let value):
            if let newValue = transform(value) {
                return Box<U>.filled(newValue)
            } else {
                return Box<U>.empty
            }
        case .empty:
            return Box<U>.empty
        }
    }
    
    public func filter(_ isIncluded: (T) -> Bool) -> Box<T> {
        switch self {
        case .filled(let value):
            return isIncluded(value) ? self : Box<T>.empty
        case .empty:
            return Box<T>.empty // or self
        }
    }
    
    public func execute(_ block: (T) -> Void) -> Box<T> {
        switch self {
        case .filled(let value):
            block(value)
            return self
        case .empty:
            return self
        }
    }
}
