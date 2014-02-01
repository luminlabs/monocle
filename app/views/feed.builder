xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Biotech Pulse"
    xml.description "Realtime sharing and discussion of articles, events, and resources of interest to biotech entrepreneurs."
    xml.link "http://news.harlembiospace.com/"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link post.url

        xml.description(%{
          #{post.summary}
          <p>
            <a href="#{post.url}">Read more</a> |
            <a href="#{post.slug_url}">Comments</a>
          </p>
        })

        xml.pubDate post.published_at.rfc822
        xml.guid post.slug
      end
    end
  end
end