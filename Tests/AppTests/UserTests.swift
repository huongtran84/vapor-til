@testable
import App
import Vapor
import XCTest
import FluentPostgreSQL

final class UserTests : XCTestCase {
    
    func testUsersCanBeRetrievedFromAPI() throws {
        let expectedName = "Alice"
        let expectedUserName = "alice"
        
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        try App.configure(&config,&env,&services)
        let app = try Application(config: config, environment: env, services: services)
        try App.boot(app)
        let conn = try app.newConnection(to: .psql).wait()
        let user = User(name: expectedName, username: expectedUserName)
        let savedUser = try user.save(on: conn).wait()
        _ = try User(name: "Luke", username: "Lukes").save(on: conn).wait()
        let responder = try app.make(Responder.self)
        let request = HTTPRequest(method: .GET, url: URL(string: "/api/users")!)
        let wrappedRequest = Request(http: request, using: app)
        
        
    }
}

