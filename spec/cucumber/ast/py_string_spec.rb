require File.dirname(__FILE__) + '/../../spec_helper'
require 'cucumber/ast/py_string'

module Cucumber
  module Ast
    describe PyString do
      it "should handle unindented" do
        ps = PyString.new("4.1\n4.2\n")
        ps.to_s.should == "4.1\n4.2\n"
      end

      it "should handle indented" do
        ps = PyString.new("  4.1\n  4.2\n")
        ps.to_s.should == "4.1\n4.2\n"
      end
      
      describe "replacing arguments" do
      
        before(:each) do
          @ps = PyString.new("<book>\n<qty>\n")
        end
      
        it "should return a new pystring with arguments replaced with values" do
          pystring_with_replaced_arg = @ps.arguments_replaced('book' => 'Life is elsewhere', 'qty' => '5')
        
          pystring_with_replaced_arg.to_s.should == "Life is elsewhere\n5\n"
        end
        
        it "should not change the original pystring" do
          pystring_with_replaced_arg = @ps.arguments_replaced('book' => 'Life is elsewhere')
          
          @ps.to_s.should_not include("Life is elsewhere")
        end

      end
      
    end
  end
end