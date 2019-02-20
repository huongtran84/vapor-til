import Vapor
import Fluent
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Example of configuring a controller
    let acronymsController = AcronymsController()
    try router.register(collection: acronymsController)
    let usersController = UsersController()
    try router.register(collection: usersController)
    let categoryController = CategoriesController()
    try router.register(collection: categoryController)
    
}

