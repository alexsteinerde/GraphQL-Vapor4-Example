import Vapor
import GraphiQLVapor
import GraphQLKit
import Graphiti

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.enableGraphiQL()
    app.register(graphQLSchema: schema, withResolver: Resolver())

    // register routes
    try routes(app)
}

final class Resolver: FieldKeyProvider {
    typealias FieldKey = FieldKeys

    private var todos: [Todo] = [
        Todo(title: "Test"),
        Todo(title: "Test2"),
    ]

    enum FieldKeys: String {
        case test
        case todos
    }

    func testFunc(req: Request, _: NoArguments) throws -> String {
        throw Abort(.notFound)
        return "test"
    }

    func todos(req: Request, _: NoArguments) -> [Todo] {
        return todos
    }
}

let schema = Schema<Resolver, Request>([
    Scalar(UUID.self),
    Type(Todo.self, fields: [
        Field(.title, at: \.title),
        Field(.id, at: \.id)
    ]),
    Query([
        Field(Resolver.FieldKey.test, at: Resolver.testFunc),
        Field(Resolver.FieldKey.todos, at: Resolver.todos),
    ]),
])

struct Todo: Codable {
    var title: String
    var id: UUID = .init()
}

extension Todo: FieldKeyProvider {
    typealias FieldKey = FieldKeys
    enum FieldKeys: String {
        case title
        case id
    }
}
