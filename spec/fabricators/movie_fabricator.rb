Fabricator(:movie) do
  title { (0...20).map { (65 + rand(26)).chr }.join }
  release_year { 1901 + rand(118) }
end
