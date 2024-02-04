//
//  Code.swift
//  Backpressure
//
//  Created by Mehrdad Behrouz Ahmadian on 2024-02-04.
//

import Combine
import Foundation

private var cancellables = Set<AnyCancellable>()
func run() {
    let subject = PassthroughSubject<Int, Never>()
    
    for i in 1...100 where Bool.random() == true {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
            print("new value sent: \(i)")
            subject.send(i)
        }
    }
    
    // MARK: - 1st Strategy: Discard Values
    
    // MARK: - Throtthle
    
//    subject
//        .throttle(
//            for: 10,
//            scheduler: DispatchQueue.main,
//            latest: true
//        )
//        .sink { value in
//            print("new value received: \(value)")
//        }
//        .store(in: &cancellables)
    
    // MARK: - Debounce
    
//    subject
//        .debounce(for: 2, scheduler: DispatchQueue.main)
//        .sink { value in
//            print("new value received: \(value)")
//        }
//        .store(in: &cancellables)
    
    // MARK: - 2nd Strategy: Deffer Values
    
    subject
//        .collect(5)
//        .collect(.byTime(DispatchQueue.main, 3))
        .collect(.byTimeOrCount(DispatchQueue.main, 10, 5))
        .sink { value in
            print("new value received: \(value)")
        }
        .store(in: &cancellables)
}
