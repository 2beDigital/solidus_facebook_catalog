require "solidus_facebook_catalog/version"
require "solidus_core"
begin
  require 'sales'
rescue LoadError
end
require "solidus_facebook_catalog/engine"
require "solidus_facebook_catalog/configure"
require "solidus_facebook_catalog/product_catalog"