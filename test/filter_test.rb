require File.dirname(__FILE__) << '/test_helper'

class FilterTest < Test::Unit::TestCase

  context "Filtering Documents" do
  
    should "filter through textile" do
      doc = document('text.textile', :filter => 'textile')
      source = doc.source(binding)
      assert source.include?('\item')
      assert source.include?('\section*{Section}')
      assert source.include?('\subsection*{Subsection}')
      assert source.include?('\subsubsection*{Subsubsection}')
      assert source.include?('\paragraph*{Paragraph}')
      assert source.include?('\subparagraph*{Subparagraph}')
    end
  
    should "fail to filter h6 textile header" do
      doc = document('h6.textile', :filter => 'textile')
      assert_raise(RuntimeError) { doc.source(binding) }
    end
  
    should "not affect layouts" do
      doc = document('text.textile',
              :filter => 'textile',
              :layout => "* layout\n* is\n<%= yield %>")
      source = doc.source(binding)
      assert source.include?("* layout"), "filtered layout"
      assert source.include?('\item'), "didn't filter content"
    end

  end
  
end
