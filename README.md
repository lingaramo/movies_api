# README

* Used GEMS
  * Devise_token_auth for authentication.
  * fast_json_api for serialization
  * RSpec for testing

* Making authenticated requests

  To make authenticated requests, first we need to get the auth tokens doing a post request to: /auth/sign_in
  including in the payload the email and the password.
  The response header of this request, if succeeded, will contain the auth headers needed for the following requests.
  The headers needed for the following authenticated requests are: 'access-token', 'expiry', 'token-type', 'uid', 'client'

* API endpoint

  POST /auth/sign_in // Authenticate user.

  GET	/auth/validate_token // Check validity of current tokens

  GET	/api/v1/people // Get complete list of people

  GET	/api/v1/people/:id // Show person

  GET	/api/v1/movie // Get complete list of movies

  GET	/api/v1/movies/:id // Show movie

------------------ Authentication nedded ------------------

- People

  POST /api/v1/people // Create new person

  PATCH	/api/v1/people/:id // Update person information

  PUT	/api/v1/people/:id // Update person information

  DELETE /api/v1/people/:id // Destroy person

- Movies

  POST /api/v1/movies // Create movie

  PATCH	/api/v1/movies/:id // Update movie

  PUT	/api/v1/movies/:id // Update movie

  DELETE	/api/v1/movies/:id // Destroy movie

  * Must include :person_id as a param in the payload

    POST /api/v1/movies/:id/add_actor // Add actor to movie

    DELETE /api/v1/movies/:id/remove_actor // Remove actor from movie

    POST /api/v1/movies/:id/add_director // Add director to movie

    DELETE	/api/v1/movies/:id/remove_director // Remove director from movie

    POST	/api/v1/movies/:id/add_producer // Add producer to movie

    DELETE /api/v1/movies/:id/remove_producer // Remove producer from movie

* Running specs

  `bundle exec rspec`

* Deployed to Heroku

  https://evening-garden-96135.herokuapp.com/

  For authenticated requests use the admin user generated in the seed file.
  
  email: admin@admin.com, password: 12345678
