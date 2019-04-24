//
//  StubHelper.swift
//  QuickAndNimbleDemoTests
//
//  Created by Ashraf on 4/22/19.
//  Copyright © 2019 BS23. All rights reserved.
//

import Foundation
@testable import QuickAndNimbleDemo

public enum StubType: String {
    case carList = "CarList"
}

class StubHelper {
    static func fromJSON<T:Decodable>(_ fileName: String, fileExtension:String="json") -> T? {
        let url = Bundle(for: self).url(forResource: fileName, withExtension: fileExtension)!
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
