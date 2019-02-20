import Foundation
import Vapor
import FluentPostgreSQL

final class User: Codable {
    var userName : String
    var name: String
    var id : UUID?
    init(name: String,username:String) {
        self.name = name
        self.userName = username
    }
}

extension User : PostgreSQLUUIDModel {
    
}
extension User : Content {}
extension User : Parameter {}
extension User : Migration {}

extension User {
    
    var acronyms: Children<User, Acronym> {
        return children(\.userID)
    }
}
