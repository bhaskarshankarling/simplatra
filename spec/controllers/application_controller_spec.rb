require_relative '../spec_helper'
describe ApplicationController do
    def app() ApplicationController end

    it "should expect true to be true" do
        expect(true).to be true
    end

end