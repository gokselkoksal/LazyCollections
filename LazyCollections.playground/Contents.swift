//: Playground - noun: a place where people can play

import UIKit

var frameIndexes: [Int] = Array(1...6)

let isFrameIncluded: (Int) -> Bool      = { print("filter"); return $0 % 2 == 0 }
let pathTransform: (Int) -> String      = { print("mapToName"); return "animation_\($0).jpeg" }
let urlTransform: (String) -> URL?      = { print("flatMapToURL"); return URL(string: "https://www.somehost.com/\($0)") }
let requestTransform: (URL) -> Request  = { print("mapToRequest"); return Request(url: $0) }
let printBlock: (Request) -> Void       = { print("print"); print($0.url.path) }

print("-------------------------------")
print("Using normal map/flatMap/filter")
print("-------------------------------")

let imageRequests1 = frameIndexes
    .filter(isFrameIncluded)
    .map(pathTransform)
    .flatMap(urlTransform)
    .map(requestTransform)

print("Total: \(imageRequests1.count) items\n")

print("-------------------------------")
print("Using lazy map/flatMap/filter")
print("-------------------------------")

let lazyImageRequests = frameIndexes
    .lazy
    .filter(isFrameIncluded)
    .map(pathTransform)
    .flatMap(urlTransform)
    .map(requestTransform)

var imageRequests2: [Request] = []
for request in lazyImageRequests {
    imageRequests2.append(request)
}

print("Total: \(imageRequests2.count) items\n")

print("-------------------------------")
print("Using Box<T>")
print("-------------------------------")

let imageRequests3: [Request] = frameIndexes.manipulate { box -> Box<Request> in
    return box
        .filter(isFrameIncluded)
        .map(pathTransform)
        .mapSome(urlTransform)
        .map(requestTransform)
}

print("Total: \(imageRequests3.count) items")
