import XCTest
@testable import final_project

class MoviesModelTests: XCTestCase {
    
    // Declare uma variável para a instância de MoviesModel que será testada
    var moviesModel: MoviesModel!

    override func setUpWithError() throws {
        // Este método é chamado antes de cada método de teste.
        // Aqui você pode inicializar objetos necessários para os testes.
        moviesModel = MoviesModel()
    }

    override func tearDownWithError() throws {
        // Este método é chamado após cada método de teste.
        // Aqui você pode liberar recursos e objetos após os testes.
        moviesModel = nil
    }

    // Crie um método de teste para verificar o comportamento do método setMovies quando o response é nulo.
    func testSetMovies_WithNilResponse_ShouldNotChangeMoviesArray() {
        // Arrange (Preparação)
        let initialMoviesCount = moviesModel.movies.count
        let responseData: Data? = nil

        // Act (Ação)
        moviesModel.setMovies(response: responseData)

        // Assert (Verificação)
        XCTAssertEqual(moviesModel.movies.count, initialMoviesCount, "O array de filmes não deveria ter sido alterado.")
    }

    // Crie um método de teste para verificar o comportamento do método setMovies quando o response contém dados válidos.
    func testSetMovies_WithValidResponse_ShouldSetMoviesArray() {
        // Arrange (Preparação)
        let responseData = """
            {
                "results": [
                    {"title": "Filme 1", "year": "2021"},
                    {"title": "Filme 2", "year": "2022"}
                ]
            }
            """.data(using: .utf8)

        // Act (Ação)
        moviesModel.setMovies(response: responseData)

        // Assert (Verificação)
        XCTAssertEqual(moviesModel.movies.count, 2, "O array de filmes deveria ter dois filmes.")
        XCTAssertEqual(moviesModel.movies[0].title, "Filme 1", "O título do primeiro filme deveria ser 'Filme 1'.")
         XCTAssertEqual(moviesModel.movies[1].releaseDate, "2022", "O ano do segundo filme deveria ser 2022.")
    }
}

