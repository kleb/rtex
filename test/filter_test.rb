require File.dirname(__FILE__) << '/test_helper'

class FilterTest < Test::Unit::TestCase

  context "Filtering Documents" do

    should "filter Textile list to LaTeX itemize environment" do  
      doc = document('itemized_list.textile', :filter => 'textile')
      assert_match '\item', doc.source(binding)
    end

    should "not affect layouts" do
      doc = document('itemized_list.textile',
              :filter => 'textile',
              :layout => "* layout\n* is\n<%= yield %>")
      source = doc.source(binding)
      assert source.include?("* layout"), "filtered layout"
      assert source.include?('\item'), "didn't filter content"
    end

  end
  
end
