import Vapor


extension Droplet {
    func setupRoutes() throws {
		
		
		do {

			print( "BEFORE" )
			for pet in try Pet.all() {
				print(pet.name, pet.age)
			}
			print( "AFTER" )

			let dog = Pet(name: "Poochie", age: 15)
			try dog.save()
			print("Doggy ID:", dog.id, dog.age) // the newly saved pet's id
	
			guard let foundDog = try Pet.find(1) else {
				throw( Abort.notFound )
			}
			print( foundDog.name )
			
			for pet in try Pet.all() {
				print(pet.name, pet.age)
			}

		} catch let error {
			print( "poop", error )
		}
		
		
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
