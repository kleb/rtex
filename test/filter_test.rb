require File.dirname(__FILE__) << '/test_helper'

class FilterTest < Test::Unit::TestCase

  context "Filtering Documents" do

    should "filter Textile list to LaTeX itemize environment" do  
      doc = document('itemized_list.textile', :filter => 'textile')
      assert_match '\item', doc.source(binding)
    end

    should "filter Textile headers to LaTeX sectioning commands" do
      doc = document('h1-5_tags.textile', :filter => 'textile')
      source = doc.source(binding)
      assert_match '\section*{Section}',             source
      assert_match '\subsection*{Subsection}',       source
      assert_match '\subsubsection*{Subsubsection}', source
      assert_match '\paragraph*{Paragraph}',         source
      assert_match '\subparagraph*{Subparagraph}',   source
    end
  
    should "not filter Textile h6 header" do
      doc = document('h6_tag.textile', :filter => 'textile')
      assert_raise(RuntimeError) { doc.source(binding) }
    end

    should "filter Textile <pre> tag into verbatim environment" do
      doc = document('pre_tag.textile', :filter => 'textile')
      source = doc.source(binding)
      assert_match '\begin{verbatim}', source
      assert_match '\end{verbatim}',   source
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
