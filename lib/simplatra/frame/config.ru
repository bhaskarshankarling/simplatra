require './app'
Dir["#{Simplatra::ROOT}/app/controllers/*.rb"].each do |file|
    controller = File.basename(file,'.*').camelize
    next if controller == 'ApplicationController'
    constant = controller.constantize
    map(constant.router) {run constant}
end
map('/') {run ApplicationController}