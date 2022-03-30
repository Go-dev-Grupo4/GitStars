


import Foundation

// MARK: - License
struct License: Codable {
    let key, name, spdxID: String
    let url: String
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
