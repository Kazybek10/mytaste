# Pagy initializer file
# Uncomment the following lines to load the extras you need:
# require "pagy/extras/bootstrap"
# require "pagy/extras/bulma"
# require "pagy/extras/foundation"
# require "pagy/extras/materialize"
# require "pagy/extras/navs"
# require "pagy/extras/semantic"
# require "pagy/extras/uikit"

# Backend Extras
# require "pagy/extras/array"
# require "pagy/extras/countless"
# require "pagy/extras/elasticsearch_rails"
# require "pagy/extras/searchkick"

# Feature Extras
# require "pagy/extras/headers"
# require "pagy/extras/items"
# require "pagy/extras/overflow"
# require "pagy/extras/metadata"
# require "pagy/extras/trim"

# Instance variables
# See https://ddnexus.github.io/pagy/api/pagy#variables
# All the Pagy::DEFAULT are set for all the Pagy instances but can be overridden
# per instance by just passing them to Pagy.new or the #pagy controller method

# Items per page
Pagy::DEFAULT[:items] = 20

# How many page links to show
Pagy::DEFAULT[:size] = 7

# Set to 1 to show page 1,2,3,4,5... (instead of 0,1,2,3,4...)
Pagy::DEFAULT[:page_param] = :page