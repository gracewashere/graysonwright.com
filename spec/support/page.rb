module SpecHelpers
  def page
    Page.new(last_response.body)
  end

  class Page
    def initialize(html)
      @html = Nokogiri::HTML(html)
    end

    def has_title?(expected)
      html.css("title").any? { |title| title.text == expected }
    end

    def match(*args)
      html.to_s.match(*args)
    end

    def has_link?(text, url)
      html.css("a[href='#{url}']").any? { |link| link.text.strip == text }
    end

    def has_tag?(tag, text)
      html.css(tag).any? { |tag| tag.text.strip == text }
    end

    def inspect
      html.to_s
    end

    attr_reader :html
  end
end
