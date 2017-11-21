# Lazy Collections

Playground to demonstrate how lazy collections work.

## `map`, `flatMap` and `filter` on a normal array:

```swift
let imageRequests = frameIndexes
    .filter(isFrameIncluded)
    .map(pathTransform)
    .flatMap(urlTransform)
    .map(requestTransform)
```

**Result:**

* We iterate over the original array `n` times.
* We create 3 redundant intermediate arrays.

## `map`, `flatMap` and `filter` on a lazy array:

```swift
let lazyImageRequests = frameIndexes
    .lazy
    .filter(isFrameIncluded)
    .map(pathTransform)
    .flatMap(urlTransform)
    .map(requestTransform)
    
var imageRequests: [Request] = []
lazyImageRequests.forEach { imageRequests2.append($0) }
```

**Result:**

* We iterate only once.
* We get each element calculated through the pipe as we access them.


