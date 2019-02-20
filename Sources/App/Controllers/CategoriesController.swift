import Vapor

struct CategoriesController : RouteCollection {
    func boot(router: Router) throws {
        let routeCategories = router.grouped("api","categories")
        routeCategories.post(Category.self, use: createHandler)
        routeCategories.get( use: getAllHandler)
        routeCategories.get(Category.parameter, use: getHandler)
        routeCategories.get(Category.parameter,"acronyms", use: getAcronymHandler)
        
    }
    func createHandler(_ req : Request,category : Category) throws -> Future<Category> {
       return category.save(on: req)
    }
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    func getHandler(_ req:Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
    func getAcronymHandler(_ req:Request) throws -> Future<[Acronym]> {
        return try req.parameters.next(Category.self).flatMap(to: [Acronym].self, { category in
             try category.acronyms.query(on: req).all()
        })
    }
}
